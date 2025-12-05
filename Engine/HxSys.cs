using System;
using System.Collections;
using Godot;
using Godot.Collections;
using Env = System.Environment;
using System.Diagnostics;
using System.IO;
using System.Linq;

namespace Sunaba.Engine;

public partial class HxSys: RefCounted
{
	public Dictionary Environment()
	{
		var envVar = Env.GetEnvironmentVariables();
		var environment = new Dictionary();
		foreach (DictionaryEntry dictionaryEntry in envVar)
		{
			environment[(string)dictionaryEntry.Key] = (string)dictionaryEntry.Value;
		}

		return environment;
	}

	public int Command(string cmdName, string[] args)
	{
    	var process = new Process();
    	var startInfo = new ProcessStartInfo
    	{
        	WindowStyle = ProcessWindowStyle.Hidden,
        	RedirectStandardOutput = false,
        	RedirectStandardError = false,
        	UseShellExecute = false
    	};

    	if (OS.GetName() == "Windows")
    	{
        	startInfo.FileName = "cmd.exe";
        	startInfo.Arguments = $"/C {cmdName} {string.Join(" ", args)}";
    	}
    	else
    	{
        	startInfo.FileName = cmdName;
        	
        	if (args != null)
        	{
				// Pass arguments directly without shell interpretation
            	foreach (var arg in args)
            	{
                	startInfo.ArgumentList.Add(arg);
            	}
        	}
    	}
	
    	process.StartInfo = startInfo;
    	process.Start();
    	process.WaitForExit();
    	return process.ExitCode;
	}
}
