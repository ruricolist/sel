.PHONY: doc api

# Set personal or machine-local flags in a file named local.mk
ifneq ("$(wildcard local.mk)","")
include local.mk
endif

PACKAGE_NAME = software-evolution-library
PACKAGE_NICKNAME = sel
# NOTE: Regenerate the following list with the following shell command:
#     grep -r "in-package :software-evolution-library"|grep -v ".git"|sed 's/^.*package ://;s/)$//'|sort|uniq
DOC_PACKAGES =								\
	software-evolution-library					\
	software-evolution-library/command-line-rest			\
	software-evolution-library/components/clang-instrument		\
	software-evolution-library/components/clang-tokens		\
	software-evolution-library/components/condition-synthesis	\
	software-evolution-library/components/fault-loc			\
	software-evolution-library/components/fix-compilation		\
	software-evolution-library/components/fodder-database		\
	software-evolution-library/components/formatting		\
	software-evolution-library/components/in-memory-fodder-database	\
	software-evolution-library/components/instrument		\
	software-evolution-library/components/java-instrument		\
	software-evolution-library/components/javascript-instrument	\
	software-evolution-library/components/json-fodder-database	\
	software-evolution-library/components/lexicase			\
	software-evolution-library/components/multi-objective		\
	software-evolution-library/components/pliny-fodder-database	\
	software-evolution-library/components/searchable		\
	software-evolution-library/components/serapi-io			\
	software-evolution-library/components/test-suite		\
	software-evolution-library/components/traceable			\
	software-evolution-library/rest					\
	software-evolution-library/rest/async-jobs			\
	software-evolution-library/rest/define-command-endpoint		\
	software-evolution-library/rest/sessions			\
	software-evolution-library/rest/std-api				\
	software-evolution-library/rest/utility				\
	software-evolution-library/software/adaptive-mutation		\
	software-evolution-library/software/ancestral			\
	software-evolution-library/software/asm				\
	software-evolution-library/software/asm-heap			\
	software-evolution-library/software/asm-super-mutant		\
	software-evolution-library/software/ast				\
	software-evolution-library/software/cil				\
	software-evolution-library/software/clang			\
	software-evolution-library/software/clang-expression		\
	software-evolution-library/software/clang-project		\
	software-evolution-library/software/clang-w-fodder		\
	software-evolution-library/software/coq				\
	software-evolution-library/software/coq-project			\
	software-evolution-library/software/csurf-asm			\
	software-evolution-library/software/diff			\
	software-evolution-library/software/elf				\
	software-evolution-library/software/elf-cisc			\
	software-evolution-library/software/elf-risc			\
	software-evolution-library/software/file			\
	software-evolution-library/software-evolution-library		\
	software-evolution-library/software/expression			\
	software-evolution-library/software/forth			\
	software-evolution-library/software/java			\
	software-evolution-library/software/java-project		\
	software-evolution-library/software/javascript			\
	software-evolution-library/software/javascript-project		\
	software-evolution-library/software/lisp			\
	software-evolution-library/software/sexp			\
	software-evolution-library/software/llvm			\
	software-evolution-library/software/parseable			\
	software-evolution-library/software/parseable-project		\
	software-evolution-library/software/project			\
	software-evolution-library/software/simple			\
	software-evolution-library/software/source			\
	software-evolution-library/software/styleable			\
	software-evolution-library/software/super-mutant		\
	software-evolution-library/software/super-mutant-clang		\
	software-evolution-library/software/super-mutant-project	\
	software-evolution-library/software/with-exe			\
	software-evolution-library/utility				\
	software-evolution-library/view

LISP_DEPS =				\
	$(wildcard *.lisp) 		\
	$(wildcard components/*.lisp)	\
	$(wildcard software/*.lisp)

TEST_ARTIFACTS = \
	test/etc/gcd/gcd \
	test/etc/gcd/gcd.s

# FIXME: move test binaries into test/bin or bin/test/
# Extend cl.mk to have a separate build target for test binaries
BINS = rest-server dump-store
TEST_BIN_DIR = test/commands
TEST_BINS = 			\
	new-clang-round-trip	\
	clang-diff-test

BIN_TEST_DIR = test/bin
BIN_TESTS =			\
	example-001-mutate

LONG_BIN_TESTS =		\
	example-002-evaluation	\
	example-003-neutral	\
	example-004-evolve

include cl.mk

test/etc/gcd/gcd: test/etc/gcd/gcd.c
	$(CC) $< -o $@

test/etc/gcd/gcd.s: test/etc/gcd/gcd.c
	gcc $< -S -masm=intel -o $@

