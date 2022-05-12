syn match pythonBuiltin 'in' conceal cchar=∈

syn match pythonOperator "\%[\(math\.\)]sqrt" conceal cchar=√
syn match pythonKeyword "\%[\(math\.\)]pi" conceal cchar=π

syn keyword pythonFunction def conceal cchar=λ
syn keyword pythonStatement lambda conceal cchar=λ
syn keyword pythonBuiltin sum conceal cchar=∑
