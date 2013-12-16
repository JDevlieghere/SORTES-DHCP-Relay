﻿/*********************************************************************
 *
 *    MPFS Generator Library
 *
 *********************************************************************
 * FileName:        MPFSlib.cs
 * Dependencies:    Microsoft .NET Framework 2.0
 * Processor:       x86
 * Complier:        Microsoft Visual C# 2008 Express Edition
 * Company:         Microchip Technology, Inc.
 *
 * Software License Agreement
 *
 * This software is owned by Microchip Technology Inc. ("Microchip") 
 * and is supplied to you for use exclusively as described in the 
 * associated software agreement.  This software is protected by 
 * software and other intellectual property laws.  Any use in 
 * violation of the software license may subject the user to criminal 
 * sanctions as well as civil liability.  Copyright 2008 Microchip
 * Technology Inc.  All rights reserved.
 *
 *
 * THE SOFTWARE AND DOCUMENTATION ARE PROVIDED "AS IS" WITHOUT 
 * WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT 
 * LIMITATION, ANY WARRANTY OF MERCHANTABILITY, FITNESS FOR A 
 * PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT SHALL 
 * MICROCHIP BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR 
 * CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, COST OF 
 * PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS 
 * BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE 
 * THEREOF), ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER 
 * SIMILAR COSTS, WHETHER ASSERTED ON THE BASIS OF CONTRACT, TORT 
 * (INCLUDING NEGLIGENCE), BREACH OF WARRANTY, OR OTHERWISE.
 *
 *
 * Author               Date   		Comment
 *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * Elliott Wood		4/17/2008	    Original
 ********************************************************************/
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;
using System.IO;
using System.IO.Compression;
using System.Text.RegularExpressions;

namespace Microchip
{
    public enum MPFSOutputFormat
    {
        BIN,
        C18,
        ASM30,
        C32
    }

    public abstract class MPFSBuilder
    {
        #region Fields
        protected String localPath;
        protected String localFile;
        protected List<string> log;
        protected List<MPFSFileRecord> files;
        protected String generatedImageName;
        protected bool indexUpdated;
        #endregion

        #region Properties
        /// <summary>
        /// Specifies the path for the image file, along with any associated index files
        /// </summary>
        protected String LocalPath
        {
            get { return this.localPath; }
            set { this.localPath = value; }
        }

        /// <summary>
        /// Specifies the name of the image file to save to the file system
        /// </summary>
        protected String LocalFile
        {
            get { return this.localFile; }
            set { this.localFile = value; }
        }

        /// <summary>
        /// Retrieves the file name of the most recently generated image
        /// </summary>
        public String GeneratedImageFileName
        {
            get { return this.generatedImageName; }
        }

        /// <summary>
        /// Retrieves the log from the last procedure
        /// </summary>
        public List<string> Log
        {
            get { return this.log; }
        }

        /// <summary>
        /// Indicates whether or not the index file was updated
        /// </summary>
        public bool IndexUpdated
        {
            get { return this.indexUpdated; }
        }
        #endregion

        #region Constructor
        /// <summary>
        /// Creates a new MPFSBuilder
        /// </summary>
        public MPFSBuilder()
        {
            // do nothing
        }
        #endregion
    
        #region Methods
        /// <summary>
        /// Adds a file to the MPFS image
        /// </summary>
        /// <param name="localName">Local file name to read</param>
        /// <param name="imageName">Name to use in image file</param>
        public abstract bool AddFile(String localName, String imageName);

        /// <summary>
        /// Recursively adds a directory of files to the image
        /// </summary>
        /// <param name="dataPath">Local directory name to add</param>
        /// <param name="imagePath">Path in MPFS image to add files to</param>
        public abstract bool AddDirectory(String dataPath, String imagePath);

        /// <summary>
        /// Generates the MPFS image and any necessary support files
        /// </summary>
        public abstract bool Generate(MPFSOutputFormat format);
        #endregion

    }

    public class MPFSClassicBuilder : MPFSBuilder
    {
        #region Fields
        public UInt32 ReserveBlock;
        #endregion

        #region Constructor
        /// <summary>
        /// Creates a new MPFS Classic image builder
        /// </summary>
        /// <param name="localPath">The directory to save the image in</param>
        /// <param name="localFile">The output file name for the image</param>
        public MPFSClassicBuilder(String localPath, String localFile)
        {
            if (!localPath.EndsWith("\\"))
                localPath += "\\";
            this.LocalPath = localPath;
            this.LocalFile = localFile;
            this.ReserveBlock = 0;
            this.log = new List<string>();
            this.files = new List<MPFSFileRecord>();
            this.indexUpdated = false;
        }
        #endregion

        #region Constants
        const byte MPFS_DATA = 0x00;
        const byte MPFS_DELETED = 0x01;
        const byte MPFS_DLE = 0x03;
        const byte MPFS_ETX = 0x04;

        String MPFS_C_HEADER =
            "/***************************************************************\r\n" +
            " * MPFSImg.c\r\n" +
            " * Defines an MPFS2 image to be stored in program memory.\r\n" +
            " *\r\n" +
            " * NOT FOR HAND MODIFICATION\r\n" +
            " * This file is automatically generated by the MPFS2 Utility\r\n" +
            " * ALL MODIFICATIONS WILL BE OVERWRITTEN BY THE MPFS2 GENERATOR\r\n" +
            " * Generated " + DateTime.Now.ToLongDateString() + " " + DateTime.Now.ToLongTimeString() + "\r\n" +
            " ***************************************************************/\r\n" +
            "\r\n" +
            "#define __MPFSIMG_C\r\n" +
            "\r\n" +
            "#include \"TCPIP Stack/TCPIP.h\"\r\n" +
            "\r\n" +
            "#if defined(STACK_USE_MPFS) && !defined(MPFS_USE_EEPROM) && !defined(MPFS_USE_SPI_FLASH)\r\n" +
            "\r\n";
        String MPFS_C_FOOTER =
            "/**************************************************************\r\n" +
            " * End of MPFS\r\n" +
            " **************************************************************/\r\n" +
            "#endif // #if defined(STACK_USE_MPFS) && !defined(MPFS_USE_EEPROM) && !defined(MPFS_USE_SPI_FLASH)" +
            "\r\n\r\n";
        String MPFS_ASM_HEADER =
            ";**************************************************************\r\n" +
            "; MPFSImg.s\r\n" +
            "; Defines an MPFS2 image to be stored in program memory.\r\n" +
            "; Defined in ASM30 assembly for optimal storage size.\r\n" +
            ";\r\n" +
            "; NOT FOR HAND MODIFICATION\r\n" +
            "; This file is automatically generated by the MPFS2 Utility\r\n" +
            "; ALL MODIFICATIONS WILL BE OVERWRITTEN BY THE MPFS2 GENERATOR\r\n" +
            "; Generated " + DateTime.Now.ToLongDateString() + " " + DateTime.Now.ToLongTimeString() + "\r\n" +
            ";**************************************************************\r\n\r\n" +
            ".equ VALID_ID,0\r\n" +
            ".ifdecl __dsPIC30F\r\n" +
            "    .include \"p30fxxxx.inc\"\r\n" +
            ".endif\r\n" +
            ".ifdecl __dsPIC33F\r\n" +
            "    .include \"p33fxxxx.inc\"\r\n" +
            ".endif\r\n" +
            ".ifdecl __PIC24H\r\n" +
            "    .include \"p24hxxxx.inc\"\r\n" +
            ".endif\r\n" +
            ".ifdecl __PIC24F\r\n" +
            "    .include \"p24fxxxx.inc\"\r\n" +
            ".endif\r\n" +
            ".if VALID_ID <> 1\r\n" +
            "    .error \"Processor ID not specified in generic include files.  New ASM30 assembler needs to be downloaded?\"\r\n" +
            ".endif\r\n" +
            "	 .text\r\n" +
            "	 .section	MPFSData,code\r\n\r\n" +
            "	 goto END_OF_MPFS	; Prevent accidental execution of constant data.\r\n" +
            "	 .global BEGIN_MPFS\r\n" +
            "BEGIN_MPFS:\r\n";
        String MPFS_ASM_FOOTER = "\r\n\r\n; End of Generated Image\r\n";
        #endregion

        #region Public Methods
        /// <summary>
        /// Adds a file to the MPFS image
        /// </summary>
        /// <param name="localName">Local file name to read</param>
        /// <param name="imageName">Name to use in image file</param>
        public override bool AddFile(String localName, String imageName)
        {
            // Skip if can't be opened
            if (!File.Exists(localName))
            {
                log.Add("\r\nERROR: Could not read " + localName);
                return false;
            }

            // Set up the new file record
            MPFSFileRecord newFile = new MPFSFileRecord();
            newFile.FileName = imageName;

            // Read the data in, escaping as it is read
            byte b;
            List<byte> data = new List<byte>(1024);
            FileStream fs = new FileStream(localName, FileMode.Open, FileAccess.Read);
            BinaryReader fin = new BinaryReader(fs);
            for (int i = 0; i < fs.Length; i++)
            {
                if(data.Count == data.Capacity)
                    data.Capacity *= 2;

                b = fin.ReadByte();
                if (b == MPFS_DLE || b == MPFS_ETX)
                    data.Add(MPFS_DLE);
                data.Add(b);
            }
            fin.Close();
            newFile.data = data.ToArray();

            // Add the file and return
            log.Add("    " + imageName + ": " + newFile.data.Length + " bytes");
            files.Add(newFile);

            return true;
        }

        /// <summary>
        /// Adds a directory to the MPFS image.  All non-hidden files will be included.
        /// </summary>
        /// <param name="dataPath">The local directory to search</param>
        /// <param name="imagePath">Ignored for MPFS Classic</param>
        /// <returns></returns>
        public override bool AddDirectory(String dataPath, String imagePath)
        {
            // Make sure directory exists
            if (!Directory.Exists(dataPath))
            {
                log.Add("\r\nERROR: Directory " + dataPath + " does not exist.");
                return false;
            }

            // Make sure directory is not the project directory
            if (this.localPath.Contains(dataPath))
            {
                log.Add("\r\nERROR: The project directory is located in the source " +
                        "directory.  The generator cannot run if the image is to be placed " +
                        "in the source directory.  Please select the base MPLAB project " +
                        "directory before continuing.");
                return false;
            }

            // Load directory members
            DirectoryInfo dir = new DirectoryInfo(dataPath);
            FileInfo[] filelist = dir.GetFiles();

            log.Add(dataPath + " :");

            // Add all sub files
            for (int i = 0; i < filelist.Length; i++)
                if ((filelist[i].Attributes & FileAttributes.Hidden) != FileAttributes.Hidden)
                    this.AddFile(filelist[i].FullName, imagePath + filelist[i].Name);

            return true;
        }

        public override bool Generate(MPFSOutputFormat format)
        {
            // Start with nothing
            generatedImageName = null;

            // Make sure all paths exist
            if (!Directory.Exists(localPath))
            {
                log.Add("\r\nERROR: Output directory \"" + localPath + "\" does not exist!");
                return false;
            }

            // Make sure we have some files
            if(files.Count == 0)
                return false;

            // Generate based on format
            try
            {
                switch (format)
                {
                    case MPFSOutputFormat.BIN:
                        return GenerateBIN(localPath + localFile);
                    case MPFSOutputFormat.C18:
                    case MPFSOutputFormat.C32:
                        return GenerateC(localPath + localFile);
                    case MPFSOutputFormat.ASM30:
                        return GenerateASM(localPath + localFile);
                    default:
                        log.Add("\r\nERROR: Invalid output format was specified.");
                        return false;
                }
            }
            catch (Exception e)
            {
                log.Add("\r\nERROR: " + e.Message);
                return false;
            }

        }

        private bool GenerateBIN(String filename)
        {
            // Open the file
            if (!filename.EndsWith(".bin", StringComparison.OrdinalIgnoreCase))
                filename += ".bin";
            BinaryWriter fout = new BinaryWriter(new FileStream(filename, FileMode.Create), Encoding.ASCII);

            // Write the FAT data
            UInt32 baseAddr = ReserveBlock + 17 * ((UInt32)files.Count + 1);
            foreach (MPFSFileRecord file in files)
            {
                fout.Write(MPFS_DATA);
                fout.Write((byte)(baseAddr));
                fout.Write((byte)(baseAddr >> 8));
                fout.Write((byte)(baseAddr >> 16));
                fout.Write((byte)(baseAddr >> 24));
                fout.Write(NormalizeFileName(file.FileName).ToCharArray());
                baseAddr += (UInt32)file.data.Length + 5;
            }
            fout.Write(MPFS_ETX);
            fout.Write((uint)0xffffffff);
            fout.Write("END OF FAT  ".ToCharArray());

            // Write the files
            foreach (MPFSFileRecord file in files)
            {
                fout.Write(file.data);
                fout.Write(MPFS_ETX);
                fout.Write((uint)0xffffffff);
            }

            // Flush the output and store the file name
            fout.Flush();
            fout.Close();
            generatedImageName = filename;
            return true;
        }

        private bool GenerateC(String filename)
        {
            // Open the file
            if (!filename.EndsWith(".c", StringComparison.OrdinalIgnoreCase))
                filename += ".c";
            StreamWriter fout = new StreamWriter(filename, false, Encoding.ASCII);

            fout.Write(MPFS_C_HEADER);

            // Write the files
            int fileIndex = 0;
            foreach (MPFSFileRecord file in files)
            {
                fout.Write("\r\n/*******************************\r\n * Begin ");
                fout.Write(NormalizeFileName(file.FileName));
                fout.Write("\r\n ******************************/\r\nstatic ROM unsigned char MPFS_");
                fout.Write(Convert.ToString(fileIndex++, 16).PadLeft(4, '0') + "[] = \r\n{");

                for (int i = 0; i < file.data.Length; i++)
                {
                    if (i % 12 == 0)
                        fout.Write("\r\n\t");
                    fout.Write("0x" + Convert.ToString(file.data[i], 16).PadLeft(2, '0') + ",");
                }

                fout.Write("\r\n\t0x04,0xff,0xff,0xff\r\n};\r\n");
            }

            // Write the FAT
            fileIndex = 0;
            fout.Write(
                "/**************************************************\r\n" +
                " * Start of MPFS FAT\r\n" +
                " **************************************************/\r\n" +
                "typedef struct\r\n" +
                "{\r\n" +
                "    unsigned char Flags;\r\n" +
                "    ROM unsigned char* Address;\r\n" +
                "    unsigned char Name[12];\r\n" +
                "} FAT_TABLE_ENTRY;\r\n" +
                "\r\n" +
                "ROM FAT_TABLE_ENTRY MPFS_Start[] = \r\n" +
                "{"
            );
            foreach (MPFSFileRecord file in files)
            {
                fout.Write("\r\n\t{ 0x00, MPFS_" + Convert.ToString(fileIndex++, 16).PadLeft(4, '0'));
                foreach (byte b in NormalizeFileName(file.FileName))
                {
                    fout.Write(", '" + (char)b + "'");
                }
                fout.Write(" },");
            }
            fout.Write(
                "\r\n\t{ 0x04, (ROM unsigned char*)0xffffff, 'E', 'N', 'D', ' ', 'O', 'F', ' ', 'F', 'A', 'T', ' ', ' ' },\r\n" +
                "};\r\n" +
                "/**************************************************\r\n" +
                " * End of MPFS FAT\r\n" +
                " **************************************************/\r\n\r\n"
            );

            fout.Write(MPFS_C_FOOTER);

            // Flush the output and store the file name
            fout.Flush();
            fout.Close();
            generatedImageName = filename;
            return true;
        }

        private bool GenerateASM(String filename)
        {
            // Open the file
            if (!filename.EndsWith(".s", StringComparison.OrdinalIgnoreCase))
                filename += ".s";
            StreamWriter fout = new StreamWriter(filename, false, Encoding.ASCII);

            fout.Write(MPFS_ASM_HEADER);

            // Write the files
            int fileIndex = 0;
            foreach (MPFSFileRecord file in files)
            {
                fout.Write("\r\n;*******************************\r\n;  Begin ");
                fout.Write(NormalizeFileName(file.FileName));
                fout.Write("\r\n;*******************************\r\n" +
                    "\tgoto\tEND_OF_MPFS_");
                fout.Write(Convert.ToString(fileIndex, 16).PadLeft(4, '0'));
                fout.Write("\t\t; Prevent accidental execution of constant data\r\n\t.global _MPFS_");
                fout.Write(Convert.ToString(fileIndex, 16).PadLeft(4, '0'));
                fout.Write("\r\n_MPFS_");
                fout.Write(Convert.ToString(fileIndex, 16).PadLeft(4, '0'));
                fout.Write(":");

                for (int i = 0; i < file.data.Length; i++)
                {
                    if (i % 12 == 0)
                        fout.Write("\r\n\t.pbyte\t");
                    fout.Write("0x" + Convert.ToString(file.data[i], 16).PadLeft(2, '0'));
                    if (i % 12 != 11 && i != file.data.Length-1)
                        fout.Write(",");
                }

                fout.Write("\r\n\t.pbyte\t0x04,0xff,0xff,0xff,0xff\r\nEND_OF_MPFS_");
                fout.Write(Convert.ToString(fileIndex++, 16).PadLeft(4, '0'));
                fout.Write(":\r\n");
            }

            // Write the FAT
            fileIndex = 0;
            fout.Write(
                ";*************************************************\r\n" +
                ";  Start of MPFS FAT\r\n" +
                ";*************************************************\r\n" +
                "\t.section\t.const,psv\r\n" +
                "\t.global _MPFS_Start\r\n" +
                "_MPFS_Start:"
            );
            foreach (MPFSFileRecord file in files)
            {
                fout.Write("\r\n\t.byte\t0x00,0x00\r\n\t.long\tpaddr(_MPFS_");
                fout.Write(Convert.ToString(fileIndex++, 16).PadLeft(4, '0'));
                fout.Write(")\r\n\t.byte\t");
                int i = 0;
                foreach (byte b in NormalizeFileName(file.FileName))
                {
                    fout.Write("'" + (char)b + "'");
                    if (++i < 12)
                        fout.Write(",");
                }
            }
            fout.Write(
                "\r\n\t.byte\t0x04,0x00\r\n\t.long\t0xffffffff" +
                "\r\n\t.byte\t'E','N','D',' ','O','F',' ','F','A','T',' ',' '\r\n\r\n" + 
                "\t.section MPFSEnd,code\r\n" +
                "END_OF_MPFS:\r\n"
            );

            fout.Write(MPFS_ASM_FOOTER);

            // Flush the output and store the file name
            fout.Flush();
            fout.Close();
            generatedImageName = filename;
            return true;
        }

        private String NormalizeFileName(String name)
        {
            if (name.Length > 12)
                name = name.Substring(0, 12);
            return name.PadRight(12).ToUpper();
        }

        #endregion
    }

    public class MPFS2Builder : MPFSBuilder
    {
        #region Fields
        private Collection<String> dynamicTypes;
        private Collection<String> nonGZipTypes;
        private DynamicVariableParser dynVarParser;
        #endregion

        #region Constants
        private const UInt16 MPFS2_FLAG_ISZIPPED = 0x0001;
        private const UInt16 MPFS2_FLAG_HASINDEX = 0x0002;
        #endregion

        #region Constructor
        /// <summary>
        /// Creates a new MPFS2 image builder
        /// </summary>
        /// <param name="localPath">The directory to save the image in, and to read/write index files</param>
        /// <param name="localFile">The output file name for the image</param>
        public MPFS2Builder(String localPath, String localFile)
        {
            if (!localPath.EndsWith("\\"))
                localPath += "\\";
            this.LocalPath = localPath;
            this.LocalFile = localFile;
            this.dynamicTypes = new Collection<string>();
            this.nonGZipTypes = new Collection<string>();
            this.log = new List<string>();
            this.files = new List<MPFSFileRecord>();
            this.dynVarParser = new DynamicVariableParser(localPath);
            this.indexUpdated = false;
        }
        #endregion

        #region Properties
        /// <summary>
        /// Sets a comma-separated list of types to be considered dynamic
        /// </summary>
        public string DynamicTypes
        {
            set
            {
                Array strings = value.Split(',');
                dynamicTypes.Clear();
                foreach (String s in strings)
                {
                    String s_trimmed = s.Replace('*', ' ').Trim();
                    if (s_trimmed.Length > 0)
                        this.dynamicTypes.Add(s_trimmed);
                }
            }
        }

        /// <summary>
        /// Sets a comma-separated list of types not to be compressed
        /// </summary>
        public string NonGZipTypes
        {
            set
            {
                Array strings = value.Split(',');
                nonGZipTypes.Clear();
                foreach (String s in strings)
                {
                    String s_trimmed = s.Replace('*',' ').Trim();
                    if (s_trimmed.Length > 0)
                        this.nonGZipTypes.Add(s_trimmed);
                }
            }
        }
        #endregion

        #region Public Methods
        /// <summary>
        /// Adds a file to the MPFS image
        /// </summary>
        /// <param name="localName">Local file name to read</param>
        /// <param name="imageName">Name to use in image file</param>
        public override bool AddFile(String localName, String imageName)
        {
            // Skip if can't be opened
            if (!File.Exists(localName))
            {
                log.Add("\r\nERROR: Could not read " + localName);
                return false;
            }

            // Set up the new file record
            MPFSFileRecord newFile = new MPFSFileRecord();
            newFile.FileName = imageName;
            newFile.fileDate = File.GetLastWriteTime(localName);

            // Read the data in
            FileStream fs = new FileStream(localName, FileMode.Open, FileAccess.Read);
            BinaryReader fin = new BinaryReader(fs);
            newFile.data = fin.ReadBytes((int)fs.Length);
            fin.Close();

            // Parse the file if necessary
            MPFSFileRecord idxFile = null;
            if (this.FileMatches(localName, this.dynamicTypes))
            {
                idxFile = dynVarParser.Parse(newFile);
            }

            // GZip the file if possible
            int gzipRatio = 0;
            if (idxFile == null && !this.FileMatches(localName, this.nonGZipTypes))
            {
                MemoryStream ms = new MemoryStream();
                GZipStream gz = new GZipStream(ms, CompressionMode.Compress, true);
                gz.Write(newFile.data, 0, newFile.data.Length);
                gz.Flush();
                gz.Close();

                // Only use zipped copy if it's smaller
                if (ms.Length < newFile.data.Length)
                {
                    gzipRatio = (int)(100 - (100 * ms.Length / newFile.data.Length));
                    newFile.data = ms.ToArray();
                    newFile.isZipped = true;
                }
            }
            
            // Add the file and return
            if (idxFile == null)
            {
                log.Add("    " + imageName + ": " + newFile.data.Length + " bytes" + 
                    ((gzipRatio > 0) ? " (gzipped by " + gzipRatio + "%)" : ""));
                files.Add(newFile);
            }
            else
            {
                log.Add("    " + imageName + ": " + newFile.data.Length + " bytes, " + (idxFile.data.Length / 8) + " vars");
                newFile.hasIndex = true;
                files.Add(newFile);
                files.Add(idxFile);
            }
            return true;
        }

        /// <summary>
        /// Recursively adds a directory to the MPFS image.  All non-hidden files will be included.
        /// </summary>
        /// <param name="dataPath">The local directory to search</param>
        /// <param name="imagePath">The base directory this folder is in the MPFS2 image</param>
        /// <returns></returns>
        public override bool AddDirectory(String dataPath, String imagePath)
        {
            // Make sure directory exists
            if (!Directory.Exists(dataPath))
            {
                log.Add("\r\nERROR: Directory " + dataPath + " does not exist.");
                return false;
            }

            // Make sure directory is not the project directory
            if (this.localPath.Contains(dataPath))
            {
                log.Add("\r\nERROR: The project directory is located in the source " +
                        "directory.  The generator cannot run if the image is to be placed " +
                        "in the source directory.  Please select the base MPLAB project " +
                        "directory before continuing.");
                return false;
            }
            
            // Load directory members
            DirectoryInfo dir = new DirectoryInfo(dataPath);
            FileInfo[] filelist = dir.GetFiles();
            DirectoryInfo[] subdirs = dir.GetDirectories();

            log.Add(dataPath + " :");

            // Add all sub files
            for (int i = 0; i < filelist.Length; i++)
                if ((filelist[i].Attributes & FileAttributes.Hidden) != FileAttributes.Hidden)
                    this.AddFile(filelist[i].FullName, imagePath + filelist[i].Name);

            // Add all subdirectories
            for (int i = 0; i < subdirs.Length; i++)
                if((subdirs[i].Attributes & FileAttributes.Hidden) != FileAttributes.Hidden)
                    this.AddDirectory(subdirs[i].FullName, imagePath + subdirs[i].Name + "/");

            return true;
        }

        /// <summary>
        /// Generates an image in the specified format
        /// </summary>
        /// <param name="format">One of the MPFSOutputFormat constants indicating the format</param>
        /// <returns>true if generation was successful, false otherwise</returns>
        public override bool Generate(MPFSOutputFormat format)
        {
            // Start with nothing as the output name
            generatedImageName = null;

            // Make sure all paths exist
            if (!Directory.Exists(localPath))
            {
                log.Add("\r\nERROR: Output directory \"" + localPath + "\" does not exist!");
                return false;
            }

            // Make sure we have some files
            if (files.Count == 0)
                return false;

            try
            {
                // Write any index files that have changed
                indexUpdated = dynVarParser.WriteIndices();
            }
            catch (Exception e)
            {
                log.Add("ERROR: " + e.Message);
                return false;
            }

            // Determine address of each file and string
            UInt32 numFiles = (UInt32)files.Count;
            UInt32 lenHeader = 8;
            UInt32 lenHashes = 2 * numFiles;
            UInt32 lenFAT = 22 * numFiles;
            UInt32 baseAddr = lenHeader + lenHashes + lenFAT;
            foreach (MPFSFileRecord file in files)
            {
                file.locStr = baseAddr;
                baseAddr += (UInt32)file.FileName.Length + 1;
            }
            foreach (MPFSFileRecord file in files)
            {
                file.locData = baseAddr;
                baseAddr += (UInt32)file.data.Length;
            }

            // Set up the writer
            try
            {
                MPFS2Writer w;
                switch (format)
                {
                    case MPFSOutputFormat.C18:
                    case MPFSOutputFormat.C32:
                        w = new MPFS2C18Writer(localPath + localFile);
                        break;
                    case MPFSOutputFormat.ASM30:
                        w = new MPFS2ASM30Writer(localPath + localFile);
                        break;
                    default:
                        w = new MPFS2BINWriter(localPath + localFile);
                        break;
                }

                // Write the image
                w.Write("MPFS");
                w.Write((byte)0x02);
                w.Write((byte)0x01);
                w.Write((UInt16)files.Count);
                foreach (MPFSFileRecord file in files)
                    w.Write((UInt16)file.nameHash);
                UInt16 flags;
                foreach (MPFSFileRecord file in files)
                {
                    w.Write(file.locStr);
                    w.Write(file.locData);
                    w.Write((UInt32)file.data.Length);
                    w.Write((UInt32)((file.fileDate.ToUniversalTime().Ticks - 621355968000000000) / 10000000));
                    w.Write((UInt32)0);
                    flags = 0;
                    if (file.hasIndex)
                        flags |= MPFS2_FLAG_HASINDEX;
                    if (file.isZipped)
                        flags |= MPFS2_FLAG_ISZIPPED;
                    w.Write(flags);
                }
                foreach (MPFSFileRecord file in files)
                {
                    w.Write(file.FileName);
                    w.Write((byte)0x00);
                }
                foreach (MPFSFileRecord file in files)
                    w.Write(file.data);

                w.Close();
                generatedImageName = w.imageName;

                log.Add("\r\nGENERATED MPFS2 IMAGE: " + w.ImageLength + " bytes");
            }
            catch (Exception e)
            {
                log.Add("\r\nERROR: " + e.Message);
                return false;
            }

            return true;
        }
        #endregion

        #region Private Methods
        private bool FileMatches(String fileName, Collection<String> endings)
        {
            foreach(String end in endings)
                if(fileName.EndsWith(end))
                    return true;
            return false;
        }
        #endregion

        #region Writer Classes
        private abstract class MPFS2Writer
        {
            public int ImageLength = 0;
            public string imageName;

            public abstract void Write(byte data);
            public abstract void Close();

            public void Write(byte[] data)
            {
                foreach (byte b in data)
                    Write(b);
            }

            public void Write(String data)
            {
                foreach (byte b in data)
                    Write(b);
            }

            public void Write(UInt16 data)
            {
                Write((byte)(data));
                Write((byte)(data >> 8));
            }

            public void Write(UInt32 data)
            {
                Write((byte)(data));
                Write((byte)(data >> 8));
                Write((byte)(data >> 16));
                Write((byte)(data >> 24));
            }
        }

        private class MPFS2BINWriter : MPFS2Writer
        {
            #region Fields
            protected BinaryWriter fout;
            #endregion

            public MPFS2BINWriter(String filename)
            {
                if (!filename.EndsWith(".bin", StringComparison.OrdinalIgnoreCase))
                    filename += ".bin";
                fout = new BinaryWriter(new FileStream(filename, FileMode.Create), Encoding.ASCII);
                imageName = filename;
            }

            public override void Write(byte data)
            {
                ImageLength++;
 	            fout.Write(data);
            }

            public override void Close()
            {
                fout.Flush();
                fout.Close();
            }
        }

        private class MPFS2C18Writer : MPFS2Writer
        {
            #region Fields
            protected StreamWriter fout;
            protected string ASCIILine;
            #endregion

            public MPFS2C18Writer(String filename)
            {
                if (!filename.EndsWith(".c", StringComparison.OrdinalIgnoreCase))
                    filename += ".c";
                fout = new StreamWriter(filename, false, Encoding.ASCII);
                imageName = filename;
                fout.Write(
                    "/***************************************************************\r\n" +
                    " * MPFSImg2.c\r\n" +
                    " * Defines an MPFS2 image to be stored in program memory.\r\n" +
                    " *\r\n" +
                    " * NOT FOR HAND MODIFICATION\r\n" +
                    " * This file is automatically generated by the MPFS2 Utility\r\n" +
                    " * ALL MODIFICATIONS WILL BE OVERWRITTEN BY THE MPFS2 GENERATOR\r\n" +
                    " * Generated " + DateTime.Now.ToLongDateString() + " " + DateTime.Now.ToLongTimeString() + "\r\n" +
                    " ***************************************************************/\r\n" +
                    "\r\n#define __MPFSIMG2_C\r\n\r\n" +
                    "#include \"TCPIPConfig.h\"\r\n" +
                    "#if !defined(MPFS_USE_EEPROM) && !defined(MPFS_USE_SPI_FLASH)\r\n\r\n" +
                    "#include \"TCPIP Stack/TCPIP.h\"\r\n" +
                    "#if defined(STACK_USE_MPFS2)\r\n\r\n" +
                    "\r\n" +
                    "/**************************************\r\n" +
					" * MPFS2 Image Data\r\n" +
					" **************************************/"
                );
            }

            public override void Write(byte data)
            {
                char ASCIIdata;

                ASCIIdata = '.';
                if (data >= 32 && data <= 126 && data != '*')   // * cannot be displayed because it would open the possibility of */ occuring in the sequence, which would mess up our block comment
                    ASCIIdata = (char)data;

                if (ImageLength % 1024 == 0)
                    ASCIILine = " " + ASCIILine;
                else
                    fout.Write(",");
                if (ImageLength % 16 == 0)
                {
                    if (ImageLength != 0)
                        fout.Write(ASCIILine + " */");
                    ASCIILine = " /* ";
                }
                if (ImageLength % 1024 == 0)
                    fout.Write("\r\n#define DATACHUNK" + Convert.ToString((ImageLength / 1024), 16).PadLeft(6, '0'));
                if (ImageLength % 16 == 0)
                    fout.Write(" \\\r\n\t");
                ASCIILine += ASCIIdata.ToString();
                fout.Write("0x" + Convert.ToString(data, 16).PadLeft(2, '0'));
                ImageLength++;
            }

            public override void Close()
            {
                if (ImageLength % 16 != 0)
                    fout.Write("".PadLeft((16-(ImageLength % 16))*5+1, ' ') + ASCIILine.PadRight(20) + " */");

                fout.Write("\r\n\r\n\r\n");
                if (ImageLength != 0)
                {
                    fout.Write("/**************************************\r\n" +
					           " * MPFS2 C linkable symbols\r\n" +
					           " **************************************/\r\n" +
                               "// For C18, these are split into seperate arrays because it speeds up compilation a lot.  \r\n" +
                               "// For other compilers, the entire data array must be defined as a single variable to \r\n" +
                               "// ensure that the linker does not reorder the data chunks in Flash when compiler \r\n" +
                               "// optimizations are turned on.\r\n" +
                               "#if defined(__18CXX)\r\n" +
                               "\tROM BYTE MPFS_Start[] = {DATACHUNK000000};\r\n");

                    for (UInt32 i = 1024; i < ImageLength; i += 1024)
                    {
                        fout.Write("\tROM BYTE MPFS_" + Convert.ToString((i / 1024), 16).PadLeft(6, '0') + "[] = {DATACHUNK"+Convert.ToString((i / 1024), 16).PadLeft(6, '0')+ "};\r\n");
                    }

                    fout.Write("#else\r\n" +
                               "\tROM BYTE MPFS_Start[] = {");
                    for (UInt32 i = 0; i < ImageLength; i += 1024)
                    {
                        fout.Write("DATACHUNK" + Convert.ToString((i / 1024), 16).PadLeft(6, '0'));
                        if (i + 1024 < ImageLength)
                            fout.Write(", ");
                    }
                    fout.Write("};\r\n" +
                               "#endif\r\n\r\n\r\n");
                }
                
                fout.Write(
                    "/**************************************************************\r\n" +
                    " * End of MPFS\r\n" +
                    " **************************************************************/\r\n" +
                    "#endif // #if defined(STACK_USE_MPFS2)\r\n" +
                    "#endif // #if !defined(MPFS_USE_EEPROM) && !defined(MPFS_USE_SPI_FLASH)\r\n"
                );
                fout.Flush();
                fout.Close();
            }
        }


        private class MPFS2ASM30Writer : MPFS2Writer
        {
            #region Fields
            protected StreamWriter fout;
            #endregion

            public MPFS2ASM30Writer(String filename)
            {
                if (!filename.EndsWith(".s",StringComparison.OrdinalIgnoreCase))
                    filename += ".s";
                fout = new StreamWriter(filename, false, Encoding.ASCII);
                imageName = filename;
                fout.Write(
                    ";**************************************************************\r\n" +
                    "; MPFSImg2.s\r\n" +
                    "; Defines an MPFS2 image to be stored in program memory.\r\n" +
                    "; Defined in ASM30 assembly for optimal storage size.\r\n" +
                    ";\r\n" +
                    "; NOT FOR HAND MODIFICATION\r\n" +
                    "; This file is automatically generated by the MPFS2 Utility\r\n" +
                    "; ALL MODIFICATIONS WILL BE OVERWRITTEN BY THE MPFS2 GENERATOR\r\n" +
                    "; Generated " + DateTime.Now.ToLongDateString() + " " + DateTime.Now.ToLongTimeString() + "\r\n" +
                    ";**************************************************************\r\n\r\n" +
                    ".equ VALID_ID,0\r\n" +
                    ".ifdecl __dsPIC30F\r\n" +
                    "    .include \"p30fxxxx.inc\"\r\n" +
                    ".endif\r\n" +
                    ".ifdecl __dsPIC33F\r\n" +
                    "    .include \"p33fxxxx.inc\"\r\n" +
                    ".endif\r\n" +
                    ".ifdecl __PIC24H\r\n" +
                    "    .include \"p24hxxxx.inc\"\r\n" +
                    ".endif\r\n" +
                    ".ifdecl __PIC24F\r\n" +
                    "    .include \"p24fxxxx.inc\"\r\n" +
                    ".endif\r\n" +
                    ".if VALID_ID <> 1\r\n" +
                    "    .error \"Processor ID not specified in generic include files.  New ASM30 assembler needs to be downloaded?\"\r\n" +
                    ".endif\r\n" +
                    "	.text\r\n" +
                    "	.section	MPFSData,code\r\n\r\n" +
                    "	goto END_OF_MPFS	; Prevent accidental execution of constant data.\r\n" +
                    "	.global BEGIN_MPFS\r\n" +
                    "BEGIN_MPFS:"
                );
            }

            public override void Write(byte data)
            {
                if (ImageLength % 12 == 0)
                    fout.Write("\r\n\t.pbyte\t");
                fout.Write("0x" + Convert.ToString(data, 16).PadLeft(2, '0'));
                ImageLength++;
                if(ImageLength % 12 != 0)
                    fout.Write(",");
            }

            public override void Close()
            {
                if (ImageLength % 12 == 0)
                    fout.Write(",");
                fout.Write(
                    "0x00\r\n" +
                    "END_OF_MPFS:\r\n\r\n" +
                    "	.section	.const,psv\r\n" +
                    "	.global	_MPFS_Start\r\n" +
                    "_MPFS_Start:\r\n" +
                    "	.long	paddr(BEGIN_MPFS)\r\n\r\n" +
                    "	.section	MPFSHelpers,code\r\n\r\n" +
                    "	.global _ReadProgramMemory\r\n" +
                    "_ReadProgramMemory:\r\n" +
                    "	push		_TBLPAG\r\n" +
                    "	mov			w1,_TBLPAG\r\n" +
                    "	mov			w0,w5\r\n" +
                    "	tblrdl		[w5],w0\r\n" +
                    "	tblrdh		[w5],w1\r\n" +
                    "	pop			_TBLPAG\r\n" +
                    "	return\r\n"
                );
                fout.Flush();
                fout.Close();
            }
        }
        #endregion
    }

    public class MPFSFileRecord
    {
        #region Fields
        private String fileName;
        public UInt16 nameHash;
	    public DateTime fileDate;
        public byte[] data;
        public UInt32 locStr;
        public UInt32 locData;
        public bool hasIndex;
        public bool isIndex;
        public bool isZipped;
        #endregion

        #region Constructor
        /// <summary>
        /// Sets up a new MPFSFileRecord
        /// </summary>
        public MPFSFileRecord()
        {
            locStr = 0;
            locData = 0;
            hasIndex = false;
            isIndex = false;
            isZipped = false;
        }
        #endregion

        public String FileName
        {
            get { return this.fileName; }
            set 
            {
                this.fileName = value;
                if(value == "")
                    this.nameHash = 0xffff;
                else
                {
                    this.nameHash = 0;
                    foreach (byte b in value)
                    {
                        nameHash += b;
                        nameHash <<= 1;
                    }
                }
            }
        }
    }
}