#include <windows.h>
#include <shlwapi.h>
#include <string>

int wmain(int argc, wchar_t* argv[])
{
    // 获取 EXE 所在目录
    wchar_t exePath[MAX_PATH];
    GetModuleFileNameW(NULL, exePath, MAX_PATH);
    PathRemoveFileSpecW(exePath);

    // 拼接 start.bat 完整路径
    wchar_t batPath[MAX_PATH];
    swprintf_s(batPath, MAX_PATH, L"%s\\@@BATNAME@@", exePath);

    // 构造命令行：start.bat + 参数
    std::wstring cmdLine = L"\"";
    cmdLine += batPath;
    cmdLine += L"\"";

    // 把所有参数拼进去
    for (int i = 1; i < argc; i++)
    {
        cmdLine += L" \"";
        cmdLine += argv[i];
        cmdLine += L"\"";
    }

    // 显示窗口执行
    STARTUPINFO si = { sizeof(si) };
    PROCESS_INFORMATION pi = {};

    CreateProcessW(
        NULL,
        (LPWSTR)cmdLine.c_str(),
        NULL, NULL,
        TRUE,
        CREATE_NEW_CONSOLE,   // 显示窗口
        NULL, NULL,
        &si, &pi
    );

    if (pi.hProcess) CloseHandle(pi.hProcess);
    if (pi.hThread) CloseHandle(pi.hThread);

    return 0;
}
