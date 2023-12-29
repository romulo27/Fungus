using System;
using System.IO;
using System.Linq;

class Program
{
    static void Main()
    {
		string codebaseFolder = Directory.GetParent(Directory.GetParent(Directory.GetCurrentDirectory()).FullName).FullName;
		Console.WriteLine("Preparing to analyze" + codebaseFolder);

		string[] files = SearchForCodeFiles(codebaseFolder);

		Console.WriteLine("Found " + files.Count() + " files.");
		Console.WriteLine("Writing to filemanifest.txt...");

		using(StreamWriter sw = new StreamWriter("filemanifest.txt"))
		{
			foreach(string file in files)
			{
				sw.WriteLine(file);
			}
		}

		Console.WriteLine("File written.");

		Console.WriteLine("Analyzing files...");

		List<string> atoms = new List<string>();
		List<string> mobs = new List<string>();
		List<string> objs = new List<string>();
		List<string> areas = new List<string>();
		List<string> turfs = new List<string>();
		List<string> datums = new List<string>();
		List<string> misc = new List<string>();
		List<string> comments = new List<string>();

		int read = 0;
		foreach(string file in files)
		{
			read++;
			if (read % 50 == 0)
			{
				Console.WriteLine("Read " + read + " out of " + files.Count());
			}
			using (StreamReader sr = new StreamReader(file))
			{
				string f = "-- FILE: " + file  + ". ----------------------";
				atoms.Add(f);
				mobs.Add(f);
				objs.Add(f);
				areas.Add(f);
				turfs.Add(f);
				datums.Add(f);
				misc.Add(f);
				comments.Add(f);
				while(sr.Peek() > -1)
				{
					string line = sr.ReadLine();
					if (line.StartsWith("/"))
					{
						if (line.StartsWith("//"))
						{
							read++;
							comments.Add(line);
							continue;
						} else
						if (line.StartsWith("/*"))
						{
							while (!line.Contains("*/"))
							{
								read++;
								comments.Add(line);
								line = sr.ReadLine();
							}
							read++;
							comments.Add(line);
							continue;
						}

						string[] split = line.Split("/");
						switch(split[1])
						{
							case "atom":
								atoms.Add(line);
								break;
							case "mob":
								mobs.Add(line);
								break;
							case "obj":
								objs.Add(line);
								break;
							case "area":
								areas.Add(line);
								break;
							case "turfs":
								turfs.Add(line);
								break;
							case "datum":
								datums.Add(line);
								break;
							default:
								misc.Add(line);
								break;
						}
					}
				}
			}
		}

		Console.WriteLine("Analysis Complete.");

		int written = -1;
		Console.WriteLine("Writing atoms...");
		using(StreamWriter sw = new StreamWriter("atoms.txt"))
		{
			written = 0;
			foreach(string line in atoms)
			{
				written++;
				if (written % 50 == 0)
					Console.WriteLine("Wrote " + written + " out of " + atoms.Count());
				sw.WriteLine(line);
			}
		}
		Console.WriteLine("Writing datums...");
		written = 0;
		using(StreamWriter sw = new StreamWriter("datums.txt"))
		{
			written = 0;
			foreach(string line in datums)
			{
				written++;
				if (written % 50 == 0)
					Console.WriteLine("Wrote " + written + " out of " + datums.Count());
				sw.WriteLine(line);
			}
		}
		Console.WriteLine("Writing objs...");
		written = 0;
		using(StreamWriter sw = new StreamWriter("objs.txt"))
		{
			written = 0;
			foreach(string line in objs)
			{
				written++;
				if (written % 50 == 0)
					Console.WriteLine("Wrote " + written + " out of " + objs.Count());
				sw.WriteLine(line);
			}
		}
		Console.WriteLine("Writing turfs...");
		written = 0;
		using(StreamWriter sw = new StreamWriter("turfs.txt"))
		{
			written = 0;
			foreach(string line in turfs)
			{
				written++;
				if (written % 50 == 0)
					Console.WriteLine("Wrote " + written + " out of " + turfs.Count());
				sw.WriteLine(line);
			}
		}
		Console.WriteLine("Writing area...");
		written = 0;
		using(StreamWriter sw = new StreamWriter("area.txt"))
		{
			written = 0;
			foreach(string line in areas)
			{
				written++;
				if (written % 50 == 0)
					Console.WriteLine("Wrote " + written + " out of " + areas.Count());
				sw.WriteLine(line);
			}
		}
		Console.WriteLine("Writing mobs...");
		written = 0;
		using(StreamWriter sw = new StreamWriter("mobs.txt"))
		{
			written = 0;
			foreach(string line in mobs)
			{
				written++;
				if (written % 50 == 0)
					Console.WriteLine("Wrote " + written + " out of " + mobs.Count());
				sw.WriteLine(line);
			}
		}
		Console.WriteLine("Writing misc...");
		written = 0;
		using(StreamWriter sw = new StreamWriter("unclassified.txt"))
		{
			written = 0;
			foreach(string line in misc)
			{
				written++;
				if (written % 50 == 0)
					Console.WriteLine("Wrote " + written + " out of " + misc.Count());
				sw.WriteLine(line);
			}
		}
		Console.WriteLine("Writing comments...");
		written = 0;
		using(StreamWriter sw = new StreamWriter("comments.txt"))
		{
			written = 0;
			foreach(string line in comments)
			{
				written++;
				if (written % 50 == 0)
					Console.WriteLine("Wrote " + written + " out of " + comments.Count());
				sw.WriteLine(line);
			}
		}
		Console.WriteLine("Files written. Analysis complete.");
    }

	static string[] SearchForCodeFiles(string folder)
	{
		string[] files = Directory.GetFiles(folder, "*dm");

		string[] subfolderFiles = Directory.GetDirectories(folder)
			.SelectMany(SearchForCodeFiles)
			.ToArray();

		return files.Concat(subfolderFiles).ToArray();
	}
}
