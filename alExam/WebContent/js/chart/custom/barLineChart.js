/**
d3 라이브러리를 이용한 BarLine 챠트
<script src="<contextPath>/js/chart/d3.min.js"></script>
https://d3js.org/d3.v4.min.js
**/
function BarLineChart(_param){

var param = _param || {};

param.div = param.div||"body";
param.margin = param.margin||{top:0, right: 20, bottom:20, left:20};
param.size = param.size||20;
param.autoYn = param.autoYn||true;
param.minMax = param.minMax||[0,1];
param.rangeYn = param.range!=undefined?true:false;
param.range = param.range||[[0.6,0.8]];
param.height = param.height;
param.interval = param.interval;

try{
//    console.log(d3.select(param.div).style("width"));
    param.width = Number(param.width||d3.select(param.div).style("width").replace("px",""));
}catch(e){
    console.log("object is not defined");
}finally{
    param.width = param.width||d3.select("body").style("width").replace("px","");
}
var width = param.width-param.margin.left-param.margin.right,
    height = param.height-param.margin.top-param.margin.bottom;

var parseTime = d3.timeParse("%Y%m%d");
var x = d3.scaleBand().rangeRound([0, width]),
    y = d3.scaleLinear().range([height, 10]);


x.domain([]);
y.domain(param.minMax);

var colorArr = param.colors||["gray","#ff9b2f", "#ff9b2f", "#ADD6FB", "#3399FF"];
var baseColumns = param.baseColumns||"date";
var columns = param.columns||["column1"];
var lineGenerator = d3.line();
var yAxisMax;

var getMinMax = function(_dataset){
    var minmax = param.minMax;
    var minVal = d3.min(minmax,function(c){return c});
    var maxVal = d3.max(minmax,function(c){return c});
    if(param.autoYn && _dataset!=undefined){
        var minData = d3.min(_dataset, function(c) { return d3.min(c.values, function(d) { return d.value; }); });
        var maxData = d3.max(_dataset, function(c) { return d3.max(c.values, function(d) { return d.value; }); });
        minVal = minData<minVal?minData:minVal;
        maxVal = maxVal<maxData?maxData:maxVal;
        maxVal = maxVal<yAxisMax?yAxisMax:maxVal;
    }
    return [minVal, maxVal];
}

var getYAxisData = function(minmax){
	var maxVal = minmax[1];
	var intrvl;
	if(isNullToString(param.interval) != ""){
		intrvl = param.interval;
		
		if(maxVal <= intrvl*2){
			// yAxis 간격의 자리수를 구한다.
			for(var i=1; i<=10; i++){
				if(maxVal / Math.pow(10, i) <= 6){
					intrvl = Math.pow(10, i-1);
					break;
				}
			}
			
			// yAxis 간격 값을 구한다
			for(var i=0; i<10; i++){
				if(intrvl * Math.pow(10, i) <= maxVal && maxVal < intrvl * Math.pow(10, i+1)){
					intrvl = (i+1) * intrvl;
					break;
				}
			}
		}
		
		// yAxis 개수를 0 포함 10개로 조정
		if(maxVal / intrvl > 9){
			while(true){
				intrvl *= 2;
				if(maxVal / intrvl < 10) break;
			}
		}
	}else{
		// 간격의 자리수를 구한다
		for(var i=1; i<=10; i++){
			if(maxVal / Math.pow(10, i) <= 6){
				intrvl = Math.pow(10, i-1);
				break;
			}
		}
		
		// 간격 값을 구한다
		for(var i=0; i<10; i++){
			if(intrvl * Math.pow(10, i) <= maxVal && maxVal < intrvl * Math.pow(10, i+1)){
				intrvl = (i+1) * intrvl;
				break;
			}
		}
		
		// yAxis 개수를 0 포함 10개로 조정
		if(maxVal / intrvl > 9){
			while(true){
				intrvl *= 2;
				if(maxVal / intrvl < 10) break;
			}
		}
	}
    var rt = [];
    var cnt = 0;
    while(true){
    	rt.push(intrvl * cnt);
    	if(intrvl * cnt >= maxVal){
    		yAxisMax = intrvl * cnt;
    		break;
    	}
    	cnt ++;
    }
	
    return rt;
}


var range = getYAxisData(getMinMax());
var rangeIntrvl = range[1] - range[0];

var rangeArr = [];
for(var i=0; i<range.length; i++){
	rangeArr.push(range[i]);
}


// 라인
var line = d3.line()
    .x(function(d,i) {
    	return x(d[baseColumns]) + param.margin.left;
	})
    .y(function(d) { return y(d.value); })
    

/**데이터 삽입**/
this.insertData = function(rawData){
	var n = rawData.length;

	var dataset = columns.map(function(group,cnt){
	    return {group:group,
	        values: rawData.map(function(d,i){
	        	var column = columns[cnt];
        		return { "group":cnt, "column":group, "date":d.date, "dy":d.dy, "actCnt":d.actCnt, "column":d[column] };
	        })
	    }
	})

	var minmax = getMinMax(dataset);
	var padding = width/(n);  
	if(n>1){
		x.range([padding/2,width+(padding/2)-10]);
	}else{
		x.range([padding/2,width]);          
	}
	    
	x.domain(rawData.map(function(d){ return d.date} ));
	y.domain(minmax);


	var chart = d3.select(param.div).append("svg")
	    .attr("width", param.width)
	    .attr("height", param.height)
	    .append("g")
		.attr("transform", "translate(" + param.margin.left + "," + param.margin.top + ")");

	var yAxisChart;
	var yAxis;

	yAxis = chart.selectAll(".yAxis")
    .data(getYAxisData(getMinMax()))
    .enter().append("g")
    .attr("class","yAxis")
    .attr("transform","translate(0,0)");
	
	yAxis.append("path")
	.attr("class","yAxis_line")
	.style("fill","none")
    .attr("stroke", function(d){
    	if(d == 0){ return "#a9a9a9"; }
    	return "#b7b7b7";
    })
    .attr("stroke-width", function(d){
    	if(d == 0){ return 1; }
    	return 0.6;
    })
    .attr("stroke-opacity", function(d){
    	if(d == 0){ return 1; }
    	return 0.5;
    })
	.attr("d",function(d){ return lineGenerator([[param.margin.left + 5, y(d)], [width+10, y(d)]]); });
	yAxis.append("text")
	.attr("class", "yAxis_text")
	.attr("x", 40-param.margin.left+2)
	.attr("y", function(d){
		return y(d)+4.5;
	})
	.text(function(d){
		return numberWithCommas(d);
	})
	.attr("text-anchor", "end")
	.attr("dominant-baseline", "center")
	.style("fill", "#969696")
	.style("font-size", "12px")
	.style("font-weight", "normal")
	;

	
	chart.selectAll(".xLabel").remove();
	var tmpVal = y(d3.min(minmax));
	var xLabel = chart.append("g")
	    .attr("class", "xLabel")
	    .attr("transform", "translate(0, "+tmpVal+")");
	

	xLabel.selectAll(".label_text").data(rawData)
	    .enter().append("text")
	    .attr("class", "label_text")
	    .attr("x", function(d, i){
	    	return x(d.date)+param.margin.left;
//	    	return (width/n)*i + 38;
    	})
	    .attr("y", 15)
	    .text(function(d){ return d.dy; })
	    .attr("text-anchor", "middle")
	    .style("font-size", "12px")
	    .style("font-weight", "normal")
	    .style("fill", "#969696");
	
	var gradient = chart.append("linearGradient")
	.attr("id", "bar_gradient")
	.attr("x1", "0%")
	.attr("y1", "100%")
	.attr("x2", "0%")
	.attr("y2", "0%");
	
	gradient.append("stop")
	  .attr("offset", "0")
	  .attr("stop-color", colorArr[1])
	;
	gradient.append("stop")
	  .attr("offset", "1")
	  .attr("stop-color", colorArr[2])
	;
	
	chart.selectAll(".barRect").remove();
	var rectSize = 25;
	var barRect = chart.selectAll(".dataBar")
	            .data(rawData)
	            .enter().append("g");
	
	barRect.append("rect")
	    .attr("class","dataBar")
		.attr("fill", "url(#bar_gradient)")
	    .attr("x", function(d, i){
	    	return x(d.date) + param.margin.left - rectSize/2;
//	    	return (width/n)*i + 30;
    	})
		.attr("width", rectSize)
//		.attr("y", function(d){
//	    	return y(minmax[0]);
//	    })
//	    .attr("rx", 2).attr("ry", 2)
//	    .transition().duration(500).delay(function(d, i) { return i * 10; })
	    .attr("y", function(d){ return y(d.actCnt); })
		.attr("height", function(d){
			return height - y(d.actCnt);
		});
	    
	chart.selectAll(".avgLine").remove();
	var avgLine = chart.selectAll(".avgLine").data(dataset)
		.enter().append("path")
		.attr("class","avgLine")
	    .style("fill","none")
	    .attr("stroke", colorArr[3])
	    .attr("stroke-width", 3)
	    .transition().delay(function(d, i) { return i * 500; }).duration(500)
	    .attrTween('d', function(d, cnt) {
	           return function(t) {
	        	   	var values = d.values.map(function(data){
	        	   		var i = d3.interpolate(minmax[0], data.column);
	        	   		return {"date":data[baseColumns], "value":i(t)};
	                });
	                return line(values);
	           }
	    })
	    ;

	chart.selectAll(".avgLine").selectAll("path").exit().remove();
} 

this.updateData = function(rawData){
	var dataset = columns.map(function(group,cnt){
	    return {group:group,
	        values: rawData.map(function(d,i){
	        	var column = columns[cnt];
        		return { "group":cnt, "column":group, "date":d.date, "dy":d.dy, "actCnt":d.actCnt, "column":d[column] };
	        })
	    }
	})
	
	var minmax = getMinMax(dataset);

	var svg = d3.selectAll(".avgLine");
    var move = svg.data(dataset);
    var enter = move.enter()
	    .append('path');
    var changeLine = d3.line()
        .x(function(d,i) {
        	return x(d.date) + param.margin.left;
    	})
        .y(function(d) { return y(d.column1); })
        
        
    move.transition().delay(function(d, i) { return i * 500; }).duration(500)
    .attr('d', changeLine(rawData))
    ;
	
}

}//bar end


function numberWithCommas(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}