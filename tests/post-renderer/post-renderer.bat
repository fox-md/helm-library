@echo off

REM fix mapped drive in TS: https://stackoverflow.com/questions/9013941/how-to-run-batch-file-from-network-share-without-unc-path-are-not-supported-me/34182234#34182234
@pushd %~dp0

REM findstr is pure windows command: https://superuser.com/questions/853580/real-windows-equivalent-to-cat-stdin/1425671#1425671
FINDSTR . > all.yaml

kustomize build . && del all.yaml || exit 1

@popd