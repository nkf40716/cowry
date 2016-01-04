
Email: ether.wcl@gmail.com
Title: C陷阱与缺陷 - 笔记
------------------

1. 词法陷阱

 1.1. 难以简单debug出的错误  
 * 注意运算符两旁要空格, 否则会造成歧义.  
 `y = x/*p /* p points at the divisor */;`
 * 在老版本的C代码中, 这两句是等同的 `a-=1` `a=-1;`

 1.2. 语法分析中的 贪心法  
 当C编译器读入一个字符后又跟了一个字符，那么编译器就必须做出判断：是将其作为两
 个分别的符号对待，还是合起来作为一个符号对待。C语言对这个问题的解决方案可以归
 纳为一个很简单的规则：每一个符号应该包含尽可能多的字符。
 * a---b 与 a -- - b 的含义相同，而与  a - -- b 的含义不同。

2. ?

 2.1. 理解函数声明

 2.2. 运算符的优先级问题：`*p++`的含义？
 * 单目运算符, 从右至左结合：`c = getc(in) != EOF`
 * 赋值运算符优先级很低，仅高于逗号运算符。

3. assert  

 `#define assert(e) if(!(e)) assert_error(__FILE_,_LINE_)`
 则对以下代码
 ```
 if(x>0 && y>0) 
     assert(x>y);
 else
     assert(y>x);
 ```
 展开后得到，
 ```
 if(x>0 && y>0) 
     if(!(x>y)) assert_error("foo.c",37);
 else
     if(!(y>x)) assert_error("foo.c",39);
 ```
 注意到，else并不是与第一个if 匹配，这与我们的期望不符。解决办法是，将宏assert定义为一个表达式而不是一个语句：
 `#define assert(e) ((void)((e)||_assert_error(_FIL_,_LINE_)))`

4. 少敲一个分号

 ```
 if (x[i] > big);
     big = x[i]
 ``` 

 ```
 if (n < 3)
     return
 logrec.time = x[0];
 ```

 ```
    struct {
        int date;
        int time;
    }

    int main(void)
    {
        return 0;
    }
```

5. 不同区间

 ```
if (x == 0)
    dosth(); error();
else {
    ...
}
```

6. what happend?

 ```
int i, a[10];
for (i = 1; i <= 10; i++)
    a[i] = 0;
```

 死循环，为什么?

7. 分号问题

 ```
    #define assert(e) \
        {if (!e) assert_error(__FILE__, __LINE__);}
```
 正确定义
```
    #define assert(e) \
        (void((e) || assert_error(__FILE__, __LINE__)))
```

8. n是int类型的数字，怎么把它的尾数单独取出并转换为char类型？

 `(n % 10 + '0')`
它有一个假设, 数字字符都是连续的/没有间隔的, 也即它假设了字符集. 在ASCII和EBCDIC上都是合法的.
但是在某些机器上有可能出错

 `"0123456789"[n % 10]`
所以要有这个又屌又正确的实现，可以解决移植性的问题

 可是它是负数怎么办？
是边界值怎么办？

9. 编译器是否允许嵌套注释？

 `/*/**/`
如果编译器允许嵌套注释，那么无论它后面跟着什么，都会被认为是注释的一部分。

 `/*/**/"*/"`
如果编译器允许嵌套注释，那么上面这句等价为一个引号。如果不允许，那么等价为字符串"*/"

 `/*/**/"*/"/*"`
如果允许，那么等价为"/*"字符串，如果不允许，……

 怎么判断编译器是否允许嵌套注释？
`/*/*/0*/**/1`
允许为1，不允许为0

10. va_list

 stargs vargs