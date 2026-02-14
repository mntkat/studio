using Godot;
using System;
using System.Globalization;
using System.Reflection;

namespace Sunaba.Engine;

public partial class PlatformService: Node
{
	public string PlatformName = "Sunaba Demo";

	public int DeviceType
	{
		get
		{
			if (OS.GetName() == "Windows" || OS.GetName() == "macOS" || OS.GetName() == "Linux")
				return 0;
			else if (OS.GetName() == "iOS" || OS.GetName() == "Android")
				return 1;
			else if (OS.GetName() == "Web")
				return 2;
			else if (OS.GetName() == "visionOS")
				return 3;
			else
				return -1;
		}
	}
	public string OsName => OS.GetName();

	public bool hasFeature(string feature)
	{
		return OS.HasFeature(feature);
	}

	public string GetVersion()
	{
		return Assembly.GetExecutingAssembly().GetName().Version?.ToString();
	}
	
	public String GetCompDate()
	{
		String compDate = GetBuildDate(Assembly.GetExecutingAssembly()).ToString(CultureInfo.CurrentCulture);//Date.GetLinkerTimestampUtc(Assembly.GetExecutingAssembly()).ToString();

		return compDate;
	}

	private static DateTime GetBuildDate(Assembly assembly)
	{
		const string buildVersionMetadataPrefix = "+build";

		var attribute = assembly.GetCustomAttribute<AssemblyInformationalVersionAttribute>();
		if (attribute?.InformationalVersion != null)
		{
			var value = attribute.InformationalVersion;
			var index = value.IndexOf(buildVersionMetadataPrefix, StringComparison.Ordinal);
			if (index > 0)
			{
				value = value.Substring(index + buildVersionMetadataPrefix.Length);
				if (DateTime.TryParseExact(value, "yyyyMMddHHmmss", CultureInfo.InvariantCulture, DateTimeStyles.None, out var result))
				{
					return result.ToUniversalTime();
				}
			}
		}

		return default;
	}

	public String GetEngineVersion()
	{
		var engineVersionInfo = Godot.Engine.GetVersionInfo();
		return engineVersionInfo["string"].ToString();
	}
}
