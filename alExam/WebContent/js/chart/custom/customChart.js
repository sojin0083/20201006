/**
d3 라이브러리를 이용한 요일 및 끼니별 칼로리 정보 챠트
<script src="<contextPath>/js/chart/d3.min.js"></script>
https://d3js.org/d3.v4.min.js
**/
function CustomChart(_param){

var param = _param || {};

//막대챠트
var bar = param.bar||{};
bar.div = bar.div||"body";
bar.margin = bar.margin||{top:30, right: 10, bottom:5, left:10};
bar.size = bar.size||20;

try{
	bar.width = Number(bar.width||d3.select(bar.div).style("width").replace("px","")) ;
	bar.height = Number(bar.height||d3.select(bar.div).style("height").replace("px",""));
}catch(e){
	console.log("bar object is not defined");
}finally{
	bar.width = bar.width||d3.select("body").style("width").replace("px","");
	bar.height = bar.height||d3.select("body").style("height").replace("px","");
}

var colorArr = param.colors||["#eeeeee", "#9b82ff", "#4486ff", "#7adef9", "#d6f259", "#ffd86d", "#ff877a"];
var goalValue = param.goalValue||2000;
var label = param.label||["월","화","수","목","금","토","일"];

var parseDate = d3.timeParse("%Y-%m"),
	formatYear = d3.format("02d");

var getMinMax = function(_dataset){
	var minmax = param.minMax;
	var minVal = d3.min(minmax,function(c){return c});
	var maxVal = d3.max(minmax,function(c){return c});
	if(param.autoYn && _dataset!=undefined){
		var minData = d3.min(_dataset, function(c) { return d3.min(c.values, function(d) { return d.value; }); });
		var maxData = d3.max(_dataset, function(c) { return d3.max(c.values, function(d) { return d.value; }); });
		minVal = minData<minVal?minData:minVal;
		maxVal = maxVal<maxData?maxData:maxVal;
	}
	return [minVal,maxVal];
}

var getYAxisData = function(minmax){
	var n = 6;
	var g = Math.round((minmax[1]-minmax[0])/n);
	
	var rt = [];
	for(var i=0; i<=n; i++){
		rt.push(minmax[0]+(i*g));
	}
	return rt;
}

var lineGenerator = d3.line();

var maxVal = getYAxisData(getMinMax())[getYAxisData(getMinMax()).length-1];
var minVal = goalValue/10;	//바 그래프에서 최소 높이

/** 데이터가공 **/
this.changeData = function (_rawData){
	return _rawData.map(function(d,i){
//		var brKcal = d.brKcal < minVal ? minVal : d.brKcal;
//		var luKcal = brKcal + (d.luKcal < minVal ? goalValue/10 : d.luKcal);
//		var diKcal = luKcal + (d.diKcal < minVal ? minVal : d.diKcal);
//		var brSnKcal = diKcal + (d.brSnKcal < minVal ? minVal : d.brSnKcal);
//		var luSnKcal = brSnKcal + (d.luSnKcal < minVal ? minVal : d.luSnKcal);
//		var diSnKcal = luSnKcal + (d.diSnKcal < minVal ? minVal : d.diSnKcal);
		
		var brKcal = d.brKcal;
		var luKcal = brKcal + d.luKcal;
		var diKcal = luKcal + d.diKcal;
		var brSnKcal = diKcal + d.brSnKcal;
		var luSnKcal = brSnKcal + d.luSnKcal;
		var diSnKcal = luSnKcal + d.diSnKcal;
		
		return {"day":label[d.day-1], "date": d.date, "brKcal":brKcal, "luKcal":luKcal, "diKcal":diKcal, "brSnKcal":brSnKcal, "luSnKcal":luSnKcal, "diSnKcal":diSnKcal, "baseCnt":maxVal}
	});
}

var y0 = d3.scaleBand()
		.rangeRound([bar.height, 50])
		.padding(0.1);

var x = d3.scaleBand().rangeRound([0, bar.width]).padding(.5);
var y = d3.scaleLinear();

var color = function(i){
	return colorArr[i];
}

var barChart = d3.select(bar.div).append("svg")
    .attr("width", bar.width + bar.margin.left + bar.margin.right)
    .attr("height", bar.height + bar.margin.top + bar.margin.bottom)
    .append("g")
    .attr("transform", "translate(" + bar.margin.left + "," + bar.margin.top + ")");

var groupLabel = barChart.append("g")
  .attr("class", "groupLabel")
  .attr("transform", "translate(" + bar.margin.left + ",5)");


x.domain([]);
y.domain(param.minMax).range([y0.bandwidth(), 0]);


var yAxis = barChart.selectAll(".yAxis")
					.data(getYAxisData(getMinMax()))
					.enter().append("g")
					.attr("class", "yAxis")
					.attr("transform", "translate(0,0)");
yAxis.append("path")
	.attr("class", "yAxis_line")
	.style("fill", "none")
	.attr("stroke", "gray")
	.attr("stroke-width", 0.4)
	.attr("d", function(d){ return lineGenerator([[25, y(d)], [bar.width-25, y(d)]]); });
yAxis.append("text")
	.attr("class", "yAxis_text")
	.attr("x", 30-bar.margin.left)
	.attr("y", function(d){
		return y(d)+4;
	})
	.text(function(d, i){
		return d;
	})
	.attr("text-anchor", "end")
	.attr("dominant-baseline", "center")
	.attr("font-size", "11px")
	.style("fill", "#a5a5a5");


/**데이터 삽입**/
this.insertData = function(rawData){
	var dataset = this.changeData(rawData);
	
	var n = rawData.length;
	var minmax = getMinMax(dataset);
 
	x.domain(dataset.map(function(d){ return d.date}));
	y.domain(minmax).range([y0.bandwidth(), 0]);

	groupLabel.selectAll(".groupLabel_text2").remove();
	groupLabel.selectAll(".groupLabel_text2")
		.data(dataset)
		.enter().append("text")
		.attr("class", "groupLabel_text2")
		//  .attr("id", function(d,i) {
		//	    return "groupLabel_text2_"+d.date; })
		.attr("x", function(d,i) {
			return i * ((bar.width-60) / n) + 35; 
		})
		.attr("y", y(0)+15)
		.text(function(d) { return d.day; })
		.attr("font-size", "11px")
		.style("fill", "#a5a5a5")
		;


	var dataGroup = ["baseCnt", "diSnKcal", "luSnKcal", "brSnKcal", "diKcal", "luKcal", "brKcal"].map(function(name,cnt){
		return dataset.map(function(d,i){
			return {group:cnt, date:d.date, value: +d[name]}
		})
	});

	barChart.selectAll(".barGroup").remove();
	var barGroup = barChart.selectAll(".bar")
		.data(dataGroup)
		.enter().append("g")
		.attr("class","barGroup")
		.attr("transform","translate(0,0)");

	barGroup.selectAll(".bar")
		.data(function(d){return d})
		.enter().append("rect")
		.attr("class", "bar")
		.style("fill", color(0))
		.attr("x", function(d, i) {
			return i * ((bar.width-60) / n) + 40;
		})
		.attr("rx", x.bandwidth()/2-2)
		.attr("ry", x.bandwidth()/2-2)
		.attr("y",  y(0))
		.transition().duration(750).delay(function(d,i){ return i*10; })
		.attr("y", function(d,i){
//			if(d.value != 0 && d.value < minVal){	return y(minVal);	}
			return y(d.value);
		})
		.attr("width", x.bandwidth()-4)
		.attr("height", function(d, i) {
//			if(d.value != 0 && d.value < minVal){	return y0.bandwidth() - y(minVal);	}
			return y0.bandwidth() - y(d.value);
		})
		.style("fill", function(d,i) {
			return color(d.group);
		})
		;
}

}//CustomChart end