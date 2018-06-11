+++
date = "2018-06-11T19:22:09+08:00"
title = "解决go NullTime的问题"
categories = ["开发"]
tags = ["go", "NullTime", "datetime", "time.Time", "sql_mode", "json"]

+++

我们经常会使用time.Time的go类型和mysql的datetime类型做关联，经常会遇到这样的报错：

`incorrect datetime value: '0000-00-00'`

也许你查了资料，很多人建议你去把sql_mode改了，然后你会发现，没用！！！

因为go的time.Time默认值会解析成`0001-01-01 00:00:00`，在mysql5.7下还是会被认为是非法的datetime。

你可能会想着，那就设置成null就好了，然而实际情况是，因为go的类型问题，你根本就设置不了time.Time为nil...

要解决这个问题，就要用NullTime，mysql的包里有官方的实现，和sql.NullString的实现方式大同小异。。。

当你以为你终于解脱的时候，查询一下试试？是不是发现Null*的内部字段都被json出来了？

要解决这个问题要自己实现json的MarshalJSON和UnmarshalJSON方法。可以利用go屌屌的struct继承的方式，把mysql.NullTime下的方法都继承过来，只需要简单实现下MarshalJSON和UnmarshalJSON方法就好了。。。


example:
```go
type MyNullTime struct {
    mysql.NullTime
}

type User struct{
    ID int
    CreatedAt MyNullTime
}

func (v *NullTime) MarshalJSON() ([]byte, error) {
    if v.Valid {
        return json.Marshal(v.Time)
    } else {
        return json.Marshal(nil)
    }
}

func (v NullTime) UnmarshalJSON(data []byte) error {
    var t time.Time
    if err := json.Unmarshal(data, &t); err != nil {
        return err
    }
    if t != (time.Time{}) {
        v.Valid = true
        v.Time = t
    } else {
        v.Valid = false
    }

    return nil
}

```

其他NullString、NullFloat、NullInt等等的实现方法都大同小异。

至此，这个问题终于可以解决了。