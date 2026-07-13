#include <windows.h>
#include <shlwapi.h>
#include <string>

int wmain(int argc, wchar_t* argv[])
{

    wchar_t exePath[MAX_PATH];
    GetModuleFileNameW(NULL, exePath, MAX_PATH);
    PathRemoveFileSpecW(exePath);


    wchar_t batPath[MAX_PATH];
    swprintf_s(batPath, MAX_PATH, L"%s\\@@BATNAME@@", exePath);


    std::wstring cmdLine = L"\"";
    cmdLine += batPath;
    cmdLine += L"\"";


    for (int i = 1; i < argc; i++)
    {
        cmdLine += L" \"";
        cmdLine += argv[i];
        cmdLine += L"\"";
    }


    STARTUPINFO si = { sizeof(si) };
    PROCESS_INFORMATION pi = {};

    CreateProcessW(
        NULL,
        (LPWSTR)cmdLine.c_str(),
        NULL, NULL,
        TRUE,
        CREATE_NEW_CONSOLE,
        NULL, NULL,
        &si, &pi
    );

    if (pi.hProcess) CloseHandle(pi.hProcess);
    if (pi.hThread) CloseHandle(pi.hThread);

    return 0;
}
