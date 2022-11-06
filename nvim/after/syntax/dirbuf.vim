syntax clear DirbufHash
syntax match DirbufHash /^#\x\{8}\t/ms=s-1 conceal
setlocal conceallevel=3 concealcursor=n
