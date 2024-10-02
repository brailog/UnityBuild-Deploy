using UnityEditor;
using UnityEditor.Build.Reporting;
using UnityEngine;
using System.IO;

public class Builder
{
    public static void BuildWebGL()
    {
        string[] scenes = new[]
        {
            "Assets/Scenes/SampleScene.unity",
        };

        string buildPath = "Builds/WebGLBuild";

        var options = new BuildPlayerOptions
        {
            scenes = scenes,
            locationPathName = buildPath,
            target = BuildTarget.WebGL,
            options = BuildOptions.None
        };

        var report = BuildPipeline.BuildPlayer(options);

        if (report.summary.result == BuildResult.Succeeded)
        {
            Debug.Log($"Build succeeded - Build written to: {options.locationPathName}");
            CompressBuild(buildPath);
        }
        else if (report.summary.result == BuildResult.Failed)
        {
            Debug.LogError("Build failed.");
        }
    }

    private static void CompressBuild(string path)
    {
        string zipPath = path + ".zip";

        if (File.Exists(zipPath))
            File.Delete(zipPath);

        System.IO.Compression.ZipFile.CreateFromDirectory(path, zipPath);
        Debug.Log($"Build compressed successfully: {zipPath}");
    }

    public static void Build()
    {
        BuildWebGL();
    }
}
