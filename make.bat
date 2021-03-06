@echo off
rem current directory
set CURDIR=%~dp0
rem remove last / so build does not error out
set CURDIR=%CURDIR:~0,-1%

SET BUILDARGS=-ldflags="-s -w" -gcflags="all=-trimpath=%CURDIR%" -asmflags="all=-trimpath=%CURDIR%"

echo [*] Updating Dependencies
go get -u

echo [*] mod tidy
go mod tidy -v

echo [*] go fmt
go fmt ./...

echo [*] go vet
go vet ./...

rem echo [*] gometalinter
rem go get -u github.com/alecthomas/gometalinter
rem gometalinter --install > nul
rem gometalinter ./...

rem echo [*] Tests
rem go test -v ./...

echo [*] Running build for windows
set GOOS=windows
set GOARCH=amd64
go build %BUILDARGS% -o reboot.exe
