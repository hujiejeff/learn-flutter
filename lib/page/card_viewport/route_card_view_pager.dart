import 'package:flutter/material.dart';

class RouteCardViewPagerDemo extends StatelessWidget {
  List<Color> colors = [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.deepOrangeAccent,
    Colors.cyan,
    Colors.lightGreen,
    Colors.lightGreen,
    Colors.lightGreen,
    Colors.lightGreen,
  ];

  List<NewsItem> dataList = [
    NewsItem(
        "中国防疫政策为何不能“躺平”？梁万年最新回应",
        "如果我们再加一把力，特别是提高老年人、儿童等这些脆弱人群的疫苗接种率，实现可控的主动免疫屏障。",
        "https://img.dutenews.com/a/10001/202204/09259303e375c5ae0a0bdca7b1409e22.png"),
    NewsItem(
        "国家卫健委：动态清零是中国防控疫情的制胜法宝",
        "实践证明，“动态清零”是当前统筹疫情防控和经济社会发展的最优选择，是当前我国疫情防控务必守住的底线。",
        "https://img.dutenews.com/a/10001/202204/72c2f896616f0446a48376cc180be18d.png"),
    NewsItem(
        "抗疫“红”榜｜社区细心服务 助推长者接种",
        "同样，龙华区大浪街道同胜社区工作人员也是挨家挨户上门宣传讲解，积极动员符合条件的老人接种",
        "https://img.dutenews.com/a/10001/202204/a2411f1322900fbec1d0257e62d73941.png"),
    NewsItem(
        "抗疫“黑”榜｜有人聚集时没戴好口罩",
        "近日，有多位市民反映，在一些社区公园或街头人群聚集处，看见有少数人没戴口罩或佩戴不规范的情况",
        "https://img.dutenews.com/a/10001/202204/a2411f1322900fbec1d0257e62d73941.png"),
    NewsItem(
        "防疫知识小课堂 | “五一”小长假，个人防护不“放假",
        "“五一”放假，个人防护仍不能“放假”，仍需做好戴口罩、勤洗手、一米距等个人防护，逛公园、商超等公共场所要配合做好扫码等防疫措施。",
        "https://img.dutenews.com/a/10001/202204/8611827423e301c1241184e94db84cac.png"),
    NewsItem(
        "关于深港跨境货物运输疫情防控措施的通告",
        "本通告自2022年4月30日0时起实施，在跨境货车运输疫情防控期间执行，后续视跨境运输疫情防控情况调整。",
        "https://img.dutenews.com/a/10001/202204/8c2bb23557b4ebfb53e7fb41b7ebe32d.png"),
    NewsItem(
        "桃源街道青年党员“疫线”勇担当",
        "疫情期间，深圳涌现出一批勇于担当、敢于作为的青年“战疫”先锋。他们践行初心使命、体现责任担当，在防控一线奋勇直前。桃源街道智园党委副书记宋超就是其中一员",
        "https://img.dutenews.com/a/10001/202204/a3cdb8e8578b51f6fc0d69eaaf948293.png"),
    NewsItem(
        "深圳疾控提醒：近期到过广州请报备！",
        "4月22日以来，曾进入过广州市白云机场的来（返）深人员应主动向所在社区、单位、酒店报备，并实行7天居家隔离+7天居家健康监测，第1、3、7、14天开展核酸检测",
        "https://img.dutenews.com/a/10001/202204/0946798f716948d3c0f25f88dad48889.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.grey.shade400,
        child: Center(
          child: CardViewPager<NewsItem>(
            dataList: dataList,
            itemBuilder: buildItem,
          ),
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, int index) {
    NewsItem newsItem = dataList[index];
    return Card(
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        child: Container(
          width: 280,
          height: 500,
          alignment: Alignment.bottomCenter,
          color: Colors.white,
          child: Column(
            children: [
              Image.network(newsItem.img),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  newsItem.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(newsItem.summary),
              )
            ],
          ),
        ));
  }
}

class CardViewPager<T> extends StatefulWidget {
  List<T> dataList;
  IndexedWidgetBuilder itemBuilder;

  CardViewPager({Key? key, required this.dataList, required this.itemBuilder})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CardViewPagerState();
}

class _CardViewPagerState extends State<CardViewPager> {
  PageController? _pageController;

  double _currPageValue = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController!.addListener(() {
      setState(() {
        _currPageValue = _pageController!.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        buildItem(3),
        buildItem(2),
        buildItem(1),
        buildItem(0),
        Positioned.fill(
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: PageView.builder(
              itemCount: widget.dataList.length,
              scrollDirection: Axis.vertical,
              physics: const PageScrollPhysics(),
              controller: _pageController,
              itemBuilder: (context, index) => Container(),
            ),
          ),
        )
      ],
    );
  }

  Widget buildItem(int index) {
    double itemOffset = 20;
    double offsetY;
    double scale;

    if (index < 3) {
      scale = 1 - (index) * 0.1;
      offsetY = (index) * itemOffset;
    } else {
      scale = 0.8;
      offsetY = itemOffset;
    }

/*    Widget child = ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 300,
        height: 400,
        color: widget.dataList[index + _currPageValue.toInt()],
        alignment: Alignment.bottomCenter,
        child: Text(
            "index: $index, offset: $offsetY, scale: $scale, page: $_currPageValue"),
      ),
    );*/
    Widget child;
    if (index + _currPageValue.toInt() >= widget.dataList.length) {
      child = Container(
        color: Colors.black,
        width: 300,
        height: 400,
      );
    } else {
      child = widget.itemBuilder(context, index + _currPageValue.toInt());
    }

    if (_currPageValue.toInt() >= widget.dataList.length - 1) {}

    return LayoutBuilder(builder: (context, constraints) {
      double aniValue = _currPageValue - _currPageValue.floor();
      if (index == 0) {
        //当前
        offsetY -= constraints.maxHeight * aniValue;
      } else if (index < 3) {
        //下面的
        scale += 0.1 * aniValue;
        offsetY -= itemOffset * aniValue;
      } else {
        //最底下的
        offsetY += itemOffset * aniValue;
      }

      return Transform.translate(
        offset: Offset(0, offsetY),
        child: Transform.scale(
          alignment: Alignment.bottomCenter,
          scale: scale,
          child: child,
        ),
      );
    });
  }
}

class NewsItem {
  String title;
  String summary;
  String img;

  NewsItem(this.title, this.summary, this.img);
}
