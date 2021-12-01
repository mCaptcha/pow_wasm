default: ## Build in debug mode
	cargo build
	wasm-pack build

clean: ## Delete build artifacts
	@cargo clean
	@-browser/pkg

coverage: ## Generate code coverage report in HTML format
	cargo tarpaulin -t 1200 --out Html

doc: ## Generate documentation
	cargo doc --no-deps --workspace --all-features

env: ## Setup development environtment
	cargo fetch

lint: ## Lint codebase
	cargo fmt -v --all -- --emit files
	cargo clippy --workspace --tests --all-features

release: env ## Build in relase mode
	wasm-pack build --release

test: ## Run frontend tests
	cargo test
	wasm-pack test --release --headless --chrome
	wasm-pack test --release --headless --firefox

xml-test-coverage: ## Generate code coverage report in XML format
	cargo tarpaulin -t 1200 --out Xml

help: ## Prints help for targets with comments
	@cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
