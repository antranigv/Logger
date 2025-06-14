MODULE Logger;

  IMPORT Out, time;

  CONST
    ERROR* = 0;
    WARN*  = 1;
    INFO*  = 2;
    DEBUG* = 3;

  TYPE
    Logger* = POINTER TO LoggerDesc;
    LoggerDesc = RECORD
      level: INTEGER;
      prefix: ARRAY 64 OF CHAR;
    END;

  PROCEDURE New*(): Logger;
  VAR self: Logger;
  BEGIN
    NEW(self);
    self.level := INFO;
    self.prefix[0] := 0X;
    RETURN self
  END New;

  PROCEDURE (self: Logger) SetLevel*(level: INTEGER);
  BEGIN
    self.level := level
  END SetLevel;

  PROCEDURE (self: Logger) SetPrefix*(p: ARRAY OF CHAR);
    VAR i: INTEGER;
  BEGIN
    i := 0;
    WHILE (i < LEN(p)) & (p[i] # 0X) DO
      self.prefix[i] := p[i]; INC(i)
    END;
    self.prefix[i] := 0X
  END SetPrefix;

  PROCEDURE (self: Logger) ClearPrefix*;
  BEGIN
    self.prefix[0] := 0X
  END ClearPrefix;

  PROCEDURE PrintTime;
    VAR year, month, day, hour, min, sec: LONGINT;
  BEGIN
    time.Now(year, month, day, hour, min, sec);

    Out.Int(year, 0); Out.Char("-");
    IF month < 10 THEN Out.Char("0") END; Out.Int(month, 0); Out.Char("-");
    IF day < 10 THEN Out.Char("0") END; Out.Int(day, 0); Out.Char("T");
    IF hour < 10 THEN Out.Char("0") END; Out.Int(hour, 0); Out.Char(":");
    IF min < 10 THEN Out.Char("0") END; Out.Int(min, 0); Out.Char(":");
    IF sec < 10 THEN Out.Char("0") END; Out.Int(sec, 0);
    Out.Char("Z")
  END PrintTime;

  PROCEDURE PrintMsg(self: Logger; levelStr, msg: ARRAY OF CHAR);
  BEGIN
    Out.String("["); PrintTime(); Out.String("] ");
    Out.String("["); Out.String(levelStr); Out.String("] ");
    IF self.prefix[0] # 0X THEN
      Out.String("["); Out.String(self.prefix); Out.String("] ");
    END;
    Out.String(msg); Out.Ln
  END PrintMsg;

  PROCEDURE PrintMsgWithInt(self: Logger; levelStr, msg: ARRAY OF CHAR; n: INTEGER);
  BEGIN
    Out.String("["); PrintTime(); Out.String("] ");
    Out.String("["); Out.String(levelStr); Out.String("] ");
    IF self.prefix[0] # 0X THEN
      Out.String("["); Out.String(self.prefix); Out.String("] ");
    END;
    Out.String(msg); Out.Int(n, 0); Out.Ln
  END PrintMsgWithInt;

  (* ===== Logging Methods ===== *)



  PROCEDURE (self: Logger) Error*(msg: ARRAY OF CHAR);
  BEGIN
  IF self.level >= ERROR THEN PrintMsg(self, "ERROR", msg) END
  END Error;

  PROCEDURE (self: Logger) ErrorInt*(msg: ARRAY OF CHAR; n: INTEGER);
  BEGIN
  IF self.level >= ERROR THEN PrintMsgWithInt(self, "ERROR", msg, n) END
  END ErrorInt;

  PROCEDURE (self: Logger) Warn*(msg: ARRAY OF CHAR);
  BEGIN
  IF self.level >= WARN THEN PrintMsg(self, "WARN", msg) END
  END Warn;

  PROCEDURE (self: Logger) WarnInt*(msg: ARRAY OF CHAR; n: INTEGER);
  BEGIN
  IF self.level >= WARN THEN PrintMsgWithInt(self, "WARN", msg, n) END
  END WarnInt;

  PROCEDURE (self: Logger) Info*(msg: ARRAY OF CHAR);
  BEGIN
  IF self.level >= INFO THEN PrintMsg(self, "INFO", msg) END
  END Info;

  PROCEDURE (self: Logger) InfoInt*(msg: ARRAY OF CHAR; n: INTEGER);
  BEGIN
  IF self.level >= INFO THEN PrintMsgWithInt(self, "INFO", msg, n) END
  END InfoInt;

  PROCEDURE (self: Logger) Debug*(msg: ARRAY OF CHAR);
  BEGIN
  IF self.level >= DEBUG THEN PrintMsg(self, "DEBUG", msg) END
  END Debug;

  PROCEDURE (self: Logger) DebugInt*(msg: ARRAY OF CHAR; n: INTEGER);
  BEGIN
  IF self.level >= DEBUG THEN PrintMsgWithInt(self, "DEBUG", msg, n) END
  END DebugInt;
END Logger.
