# Logger for Vishap Oberon Compiler (voc)

A minimal, structured logging library for [Vishap Oberon](https://vishap.oberon.am), suitable for CLI programs and system-level Oberon modules.

## Features
- Outputs to standard output using Out
- Suppress or increase verbosity
- Four log levels: ERROR, WARN, INFO, DEBUG
- ISO 8601 UTC timestamps with Z suffix
- Optional module prefix


## Log Format

Each message follows this format:

```
[YYYY-MM-DDTHH:MM:SSZ] [LEVEL] [prefix] message
```

The `[prefix]` section is omitted if none is set.

## Example Output

```
[2025-06-15T04:06:38Z] [INFO] Logger initialized
[2025-06-15T04:06:38Z] [INFO] The answer to life, the universe, and everything: 42
[2025-06-15T04:06:38Z] [WARN] [Web Server] Web Server is loading slowly
[2025-06-15R06:00:03R] [ERROR] [Web Server] Something went wrong...
[2025-06-15R06:00:03R] [DEBUG] [Web Server] File descriptor: 73
[2025-06-15R06:00:03R] [INFO] Prefix cleared
```

## Usage

```
MODULE LoggerTest;
  IMPORT Logger;
VAR log: Logger.Logger;
BEGIN
  log := Logger.New();

  log.SetLevel(Logger.DEBUG);
  log.Info("Program initialized");
  log.InfoInt("The answer to life, the universe, and everything: ", 42);

  log.SetPrefix("Web Server");
  log.Warn("Web Server is loading slowly");
  log.WarnInt("Current threads: ", 4)
END LoggerTest.
```

## Building

```
make
```

## Tests

```
make test
```

## Dependencies
- For building: `voc` (duh!)
- For testing: `awk`

## License

BSD 2-Clause License

