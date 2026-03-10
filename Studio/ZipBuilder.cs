using System;
using System.Buffers.Text;
using System.IO;
using System.IO.Compression;
using Godot;

namespace Sunaba.Studio;

public partial class ZipBuilder : RefCounted
{
    private string tempPath = "";

    public ZipBuilder()
    {
        
    }
    
    public void CreateZip(string path)
    {
        tempPath = path + "_output/";

        if (!Directory.Exists(tempPath))
        {
            Directory.CreateDirectory(tempPath);
        }
    }

    public void AddToZipFile(string path, string bytes)
    {
        var tempFilePath = tempPath + path;
        File.WriteAllBytes(tempFilePath, Marshalls.Base64ToRaw(bytes));
    }

    public void BuildZip(string path)
    {
        if (File.Exists(path))
        {
            File.Delete(path);
        }
        ZipFile.CreateFromDirectory(tempPath, path);
    }
}