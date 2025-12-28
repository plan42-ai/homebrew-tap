.PHONY lint:
lint:
	brew untap plan42/tap &> /dev/null || true
	brew tap plan42/tap $$(pwd)
	brew audit plan42 --strict --new
	brew style plan42
