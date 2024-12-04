GOOS=linux
CGO_ENABLED=1
go run ./cli tunnel exit
rm bin/libcore.dll bin/HiddifyCli.exe
CGO_LDFLAGS=
go build -trimpath -tags with_gvisor,with_quic,with_wireguard,with_ech,with_utls,with_clash_api,with_grpc -ldflags="-w -s" -buildmode=c-shared -o bin/libcore.dll ./custom
go get github.com/akavel/rsrc
go install github.com/akavel/rsrc
rsrc  -ico ./assets/hiddify-cli.ico -o cli/bydll/cli.syso

cp bin/libcore.dll .
CGO_LDFLAGS="libcore.dll"
GOOS=linux GOARCH=amd64 go build  -o bin/HiddifyCli ./cli/
rm libcore.dll
