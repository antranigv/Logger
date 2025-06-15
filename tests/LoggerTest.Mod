MODULE LoggerTest;

  IMPORT Logger;

VAR
  log: Logger.Logger;

BEGIN
  (* Initialize logger instance *)
  log := Logger.New();

  (* Show default level (INFO) in action *)
  log.Info("Logger initialized");
  log.InfoInt("The answer to life, the universe, and everything: ", 42);

  (* Prefix usage *)
  log.SetPrefix("Web Server");
  log.Warn("Web Server is loading slowly");
  log.WarnInt("Current threads: ", 4);

  log.Error("Something went wrong...");
  log.ErrorInt("The function returned: ", -1);

  (* Switch to DEBUG level *)
  log.SetLevel(Logger.DEBUG);
  log.Debug("This is a debug message");
  log.DebugInt("File descriptor: ", 73);

  (* Clear prefix *)
  log.ClearPrefix();
  log.Info("Prefix cleared");

  (* Suppress all output *)
  log.SetLevel(-1);
  log.Error("This should NOT print");
  log.Debug("This should NOT print");
END LoggerTest.
