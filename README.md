# R Operator

Provide R operator for vim.
For example, 'Riw' is similar (but not same) to 'viwp'.

## Configuration
NOTE: by default this plugin does not add any new commands.
You MUST map keys to the R operator.
Here is the recommended way for mapping:

```vim
nmap R <Plug>ReplaceOperator
vmap R <Plug>ReplaceOperator
nmap RR 0Rg$

nmap Rr <Plug>ReplaceOperatorWithLastReplaced
vmap Rr <Plug>ReplaceOperatorWithLastReplaced
nmap RrR 0Rrg$
```

## (Advanced) How does R manipulate registers
This plugin use '-' register to save replaced text.

When you use <Plug>ReplaceOperator, '"' register is used to replace the
selected text.

When you use <Plug>ReplaceOperatorWithLastReplaced, '-' register is used
to replace the selected text.
