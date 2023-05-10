TEST_DIR:=test

.PHONY: default test

default:

test: default
	@cd $(TEST_DIR) && set -o errexit && \
	for test in *.sh; do echo "Starting "$$(basename "$$test" .sh); "./$$test"; done 

clean:
