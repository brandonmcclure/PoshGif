ifeq ($(OS),Windows_NT)
    SHELL := pwsh.exe
else
   SHELL := pwsh
endif
.SHELLFLAGS := -NoProfile -Command 

all: build

build: 
	./Build-Modules.ps1
%:
	./Build-Modules.ps1 -moduleName @('$*.psm1')

local_deploy:
	Copy-Item ./PoshGif "$$($$env:USERPROFILE)\Documents\PowerShell\Modules" -force -Recurse
