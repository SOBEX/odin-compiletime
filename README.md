# Odin compiletime library

## how to

compiletime code snippets that cannot be expressed in functions

## test

tests for how_to

## brainfuck

brainfuck interpreters fully at compiletime and brainfuck parsers at compiletime that emit more optimized runtime procedures

## match

string matching similar to `core:text/match` but with compiletime known patterns that emits a single optimized procedure without any runtime pattern parsing

## fmt

printing similar to `core:fmt` but with compiletime known patterns

## OCL

compiler for a simple ssa-python-ish language that lowers to compiled odin (without tokenizer stage)

## scratch

random experiments

### scratch/calculator.odin

compiletime evaluator for math expressions (with tokenizer stage)
