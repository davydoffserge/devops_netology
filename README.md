#devops-netology

#1)git show aefea 
#aefead2207ef7e2aa5dc81a34aedf0cad4c32545

#2)коммит 85024d3 соответствует тэгу v0.12.23,
#git show 85024d3.

#3)у коммита b8d720 2 родителя, 56cd7859e и 9ea88f22f.
#git show b8d720, соответственно хеши
#56cd7859e05c36c06b56d013b55a252d0bb7e158, и 
#9ea88f22fc6269854151c571162c5bcf958bee2b.

#4)git log --pretty=format:"%h %s" v0.12.23..v0.12.24
#между v0.12.23 и v0.12.24
#b14b74c49 [Website] vmc provider links
#3f235065b Update CHANGELOG.md
#6ae64e247 registry: Fix panic when server is unreachable
#5c619ca1b website: Remove links to the getting started guide's old location
#06275647e Update CHANGELOG.md
#d5f9411f5 command: Fix bug when using terraform login on Windows
#4b6d06cc5 Update CHANGELOG.md
#dd01a3507 Update CHANGELOG.md

#5) функция func providerSource, была создана в коммите 8c928e835.  
#git log -S 'func providerSource(' --pretty=format:"%h, %an, %ad, %s"

#6)функция globalPluginDirs была изменена в коммите 8364383c3. 
#git log -S 'func globalPluginDirs(' --pretty=format:"%h, %an, %ad, %s",
#хэш 8364383c359a6b738a436d1b7745ccdce178df47.

#7)над функцией synchronizedWriters трудились двое: James Bardin и Martin Atkins,
#команда git log -S 'func synchronizedWriters(' --pretty=format:"%h, %an, %ad, %s" выводит:
#bdfea50cc James Bardin, и 5ac311e2a, Martin Atkins.
#Смотрим коммиты git show; видим создатель Martin Atkins.
