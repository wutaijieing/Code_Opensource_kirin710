# 华为麒麟710内核  
实验性质项目。  
目的：兼容KernelSU。

## Changlog:
1. 2023.04.10 删除华为间谍和SELinux监视。
2. 增加KernelSU，开启KPROBES，关闭CONFIG_HISI_PMALLOC。[注：1]
3. 关闭AVB验证
4. 完全移植KernelSU


#### 注
+ > 注1  ` ../include/linux/pmalloc.h: In function ‘pzalloc’:
../include/linux/pmalloc.h:109:35: error: ‘__GFP_ZERO’ undeclared (first use in this function)
  return pmalloc(pool, size, gfp | __GFP_ZERO); `  
  > include/linux/pmalloc.h 文件调用编译，但是已经无需此功能，
  > 在此文件开头可以看到定义：`#ifdef CONFIG_HISI_PMALLOC`
  > 所以在defconfig内直接关闭即可。