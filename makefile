.PHONY: types build

types:
	nix-shell --command 'npx openapi-generator-cli generate -i open-api-spec.yaml -g rust -o ./src-tauri/agent_client'
	nix-shell --command 'typeshare ./src-tauri/src/types.rs --lang typescript --output-file ./src/components/types/src_tauri.ts --go-package tmp'
	nix-shell --command 'npx openapi-typescript open-api-spec.yaml --output src/components/types/agent-spec.ts'
	nix-shell --command 'npx openapi-typescript-codegen   --input open-api-spec.yaml   --output src/lib/api   --client fetch'


build:
	nix-shell --command 'yarn run tauri build'

dev:
	nix-shell --command 'yarn run tauri dev'

install:
	nix-shell --command 'yarn install'

lint:
	nix-shell --command 'yarn run check'

all: types lint build

release:
	nix-shell --command 'yarn run release'
