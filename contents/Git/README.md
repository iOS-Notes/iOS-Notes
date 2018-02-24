# Git 常用命令备忘

---

# 1.添加 Tag

例如：2.333

```
git tag -a 2.333 -m "2.333 版本的备注信息."
```

# 2.上传本地 Tag 到服务器

```
git push origin --tags
```

# 3.删除本地 Tag

例如：2.333

```
git tag -d 2.333
```

这时可以趁机同时删除远程 Tag

```
git push origin :refs/tags/2.333
```

# 4.同步本地与远程分支

删除远程不存在的本地分支

```
git fetch --p
```

# 5.合并本地的最后两次 Commit

```
git reset --soft HEAD^git commit --amend
```

# 6.修改上一次的 Commit 信息

```
git commit --amend
```

# 7.撤销所有未提交的本地修改

```
git checkout .
```

# 8.删除远程仓库地址

```
git remote remove origin
```

# 9.添加远程仓库地址

```
git remote add origin https://git.coding.net/eyrefree/xxx.git
```

# 10.Push 本地分支到指定远程分支

例如：Push 本地当前分支到远程仓库 origin 的 master 分支

```
git push -u origin master
```

