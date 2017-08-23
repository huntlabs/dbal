module dbal.exception;

import dbal;
import std.exception;

class DbalException : Exception
{
    this(string msg, string file = __FILE__, size_t line = __LINE__)
    {
        super(msg, file, line);
    }
}
