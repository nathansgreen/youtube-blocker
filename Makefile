TEST_DIR:=test

.PHONY: default test

default:

test: default
# mark tests as not user-executable and they will be skipped
# the find command is inherently buggy and inadequate, so we will leave it at that
	@cd $(TEST_DIR) && set -o errexit && \
	find . -perm -u=x -name '*.sh' -type f \
		-exec sh -c 'echo "Starting $$(basename "{}" .sh)"; {}' ';'

clean:
