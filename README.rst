alfred-workflow-in-python-tutorial
==============================================================================

.. contents::
    :depth: 1
    :local:


MacOS 上的神软 Alfred
------------------------------------------------------------------------------

`Alfred <https://www.alfredapp.com/>`_ 是 MacOS 平台上的一款生产力软件. 有些人称之为快速启动器.




Alfred Workflow 简介
------------------------------------------------------------------------------


用 Python 开发 Alfred Workflow 的核心原理
------------------------------------------------------------------------------

首先我们来理解 Alfred 是如何与用户交互的. 我们以下图为例:

.. image:: https://user-images.githubusercontent.com/6800411/126883941-e0f9e64a-b80b-43f4-85bf-a61d38623c20.png

1. 匹配 Alfred Keyword: 首先用户输入关键字, 在本例中关键字是 fts movie. 在输入关键字时, Alfred 会将用全文搜索搜索所有软件内定义过的关键字, 提示用户可能的命令, 并提供 Tab 自动补全功能.
2. 匹配到关键字后, 你可以直接输入回车, 或是输入一些 参数 (Query). 然后 Alfred 会对 Query 进行处理, 返回一些 Item. 你可以对 Item 进行选择, 或者进行下一步的操作. 而这些操作背后对应的行为, 你可以在 Alfred Workflow 中进行定义, 比如打开文件, 打开浏览器.

**重点**

对于开发而言, 最重要的是理解 编程模型中的 输入 和 输出. 在这个例子里可以很清晰的看到.

输入:

- 关键字 Keyword: fts movie
- 参数 Query: Drama

输出:

一些 Item, 每个 Itenm 都有这些元素:

- 标题 Title: 也就是大写的部分
- 副标题 Subtitle: 也就是小字的部分
- 自动补全 Auto Complete: 这部分是看不到的, 是你按下 Tab 键自动补全出来的字符串
- 参数 Arg: 这部分也是看不到的, 是你按下 Enter 回车确定后传递给下一个操作的参数, 也是一个字符串
- 图标 Icon: 本例中没有, 也就是左边的图标.

理解了这个编程模型, 我们编程的重点则是编写一个函数, 能够根据输出, 返回正确的输出, 并且包括这种错误情况的处理.


用 Python 开发 Alfred Workflow 的难点
------------------------------------------------------------------------------

1. 苹果电脑上自带的 Python 是 Python2. 虽然 Alfred 可以用 Python3 作为 Workflow 的运行时, 但是为了使用 Workflow 来配置 Python 环境是不现实的. 你的 Workflow 的使用者不一定会正确的在 Mac 上配置 Python 环境. **所以你只能用 Mac 上自带的 Python 开发**, 而为系统自带的 Python 安装第三方库的行为本身是很危险的. **这也会使得使用在 Alfred Workflow 中使用第三方库变得非常麻烦**.
2. 功能测试困难.
3. 集成测试困难. 就算你确定你的功能测试 100% 没问题, 但是你最终还是希望能够在 Alfred 中实际使用你的 Workflow.





手动给苹果系统自带的 Python2 装 pip
------------------------------------------------------------------------------

由于 MacOS 系统自带的 python2.7 存在的意义只是为了兼容非常老的软件, 以后还是会全面迁徙到 python3 的. 而 /usr/bin/pip 已经不复存在了, 只有 /usr/bin/pip3. 而在开发中我们还是需要 python2.7 以及 pip2.7 环境来安装第三方包的. 而 pip 通常的安装方式是通过 get-pip.py 脚本, 该方法的原理是将所有的 pip 二进制代码编码成 base85. 而这个 get-pip.py 永远只能给你安装最新的 pip 版本. 又因为 pip 从 2021-01-23 的 20.3.4 版本后, 就再也不支持 python2 了, 所以我们只能手动找到 20.3.4 的 release, 并从源码安装了.

.. code-block:: bash

    # MacOS system python2.7 doesn't come with pip
    # And the get-pip.py method no longer work since the pip drop python2.7 support
    # from Jan 23 2021. We have to manually install it from source code
    # pip==20.3.4 is the last version support Python2.7

    # download source code
    wget https://github.com/pypa/pip/archive/refs/tags/20.3.4.tar.gz

    # extract code
    tar -xf 20.3.4.tar.gz

    # get into directory
    cd pip-20.3.4

    # manual install
    sudo /usr/bin/python setup.py install


创建 Python2.7 虚拟环境
------------------------------------------------------------------------------

.. code-block:: bash

    # 创建虚拟环境
    virtualenv -p /usr/bin/python venv

    source venv/bin/activate

