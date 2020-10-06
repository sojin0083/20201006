/**
d3 라이브러리를 이용한 활동량 Bar 챠트
<script src="<contextPath>/js/chart/d3.min.js"></script>
https://d3js.org/d3.v4.min.js
**/
function BarChart(_param){

var param = _param || {};

try{
//    console.log(d3.select(param.div).style("width"));
    param.width = Number(param.width||d3.select(param.div).style("width").replace("px",""));

    if(isNullToString(param.yAxisDiv) != ""){
    	yAxisWidth = param.margin.left + 5;
    }
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
var goalValue = param.goalValue||[10000];
var userObjVal = param.userObjVal||0;
var healthYn = param.healthYn||"N";
var userGoalValue = goalValue[0];
var yAxisMax = userGoalValue;	//yAxis 최대값

var lineGenerator = d3.line();

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
    return [minVal,maxVal];
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

/**데이터 삽입**/
this.insertData = function(rawData){
	
	var n = rawData.length;
//	width = n > 7 ? n * width/7 : width;
	width = isNullToString(param.yAxisDiv) != "" && n > 7 ? n * width/7 - yAxisWidth : width-5;
	
	var dataset = rawData.map(function(group,cnt){
	    return {group:group,
	        values: rawData.map(function(d,i){
        		return { "group":cnt, "column":group, "date":d.date, "dy":d.dy, "totCnt":d.totCnt, "excsCnt":d.excsCnt };
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


	var barChart = d3.select(param.div).append("svg")
	    .attr("width", isNullToString(param.yAxisDiv) != "" ? width : param.width)
	    .attr("height", param.height)
	    .append("g")
		.attr("transform", "translate(" + param.margin.left + "," + param.margin.top + ")")
	    .attr("transform","rotate(90 200 200)");

	var yAxisChart;
	var yAxis;
	
	if(isNullToString(param.yAxisDiv) != ""){
		yAxisChart = d3.select(param.yAxisDiv).append("svg")
		.attr("width", yAxisWidth)
		.attr("height", param.height)
		.append("g")
		.attr("transform", "translate(" + param.margin.left + "," + param.margin.top + ")");
		
		barChart.attr("transform", "translate(0," + param.margin.top + ")");
		
		yAxis = yAxisChart.selectAll(".yAxis")
		.data(getYAxisData(getMinMax()))
		.enter().append("g")
		.attr("class","yAxis")
		.attr("transform","translate(0,0)");
		 
		yAxis.append("text")
		.attr("class", "yAxis_text")
		.attr("x", -5)
		.attr("y", function(d){
			return y(d)+4.5;
		})
		.text(function(d){
			return d.toFixed(0);
		})
		.attr("text-anchor", "end")
		.attr("dominant-baseline", "center")
	    .style("fill", "#a9a9a9")
		.style("font-size", "12px")
		.style("font-weight", "normal")
		;
		
		yAxis.append("path")
		.attr("class","yAxis_line")
		.attr("fill","none")
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
		.attr("d",function(d){ return lineGenerator([[0,y(d)],[width,y(d)]]) });
		
		var yAxisLine = barChart.selectAll(".yAxis")
		.data(getYAxisData(getMinMax()))
		.enter().append("g")
		.attr("class","yAxis")
		.attr("transform","translate(0,0)");
		
		yAxisLine.append("path")
		.attr("class","yAxis_line")
		.attr("fill","none")
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
		.attr("d",function(d){ return lineGenerator([[0,y(d)],[width,y(d)]]) });

	}else{
		yAxis = barChart.selectAll(".yAxis")
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
		.attr("d",function(d){ return lineGenerator([[20, y(d)], [width+10, y(d)]]); });
		
		yAxis.append("text")
		.attr("class", "yAxis_text")
		.attr("x", 37-param.margin.left)
		.attr("y", function(d){
			return y(d)+4.5;
		})
		.text(function(d, i){
		//	if(Math.abs(userGoalValue - rangeArr[i]) < (rangeIntrvl/2)){
		//		return "";
		//	}
			return d;
		})
		.attr("text-anchor", "end")
		.attr("dominant-baseline", "center")
		.style("fill", "#a9a9a9")
		.style("font-size", "12px")
		.style("font-weight", "normal")
		;
	}

	
	barChart.selectAll(".xLabel").remove();
	var tmpVal = y(d3.min(minmax));
	var xLabel = barChart.append("g")
	    .attr("class", "xLabel")
	    .attr("transform", "translate(0, "+tmpVal+")");
	

	xLabel.selectAll(".label_text").data(rawData)
	    .enter().append("text")
	    .attr("class", "label_text")
	    .attr("x", function(d, i){
//	    	return x(d.date)+10;
//	    	return (width/n)*i + 38;
	    	return ((width-param.margin.left)/n)*i + 38;
    	})
	    .attr("y", 15)
	    .text(function(d){
	    	if(param.pdType == 1 || param.pdType == 3){
		    	return d.dy;
		    }else{
		    	var convertDt = d.date;
		    	var mmdd =  setDateFormat(convertDt,"MM.DD")
		    	return mmdd;
		    }
	    })
	    .attr("text-anchor", "middle")
	    .style("font-size", "12px")
	    .style("font-weight", "normal")
	    .style("fill", "#a9a9a9");
	
	var gradient = barChart.append("linearGradient")
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
	
	var gradient = barChart.append("linearGradient")
	.attr("id", "excsbar_gradient")
	.attr("x1", "0%")
	.attr("y1", "100%")
	.attr("x2", "0%")
	.attr("y2", "0%");
	
	gradient.append("stop")
	.attr("offset", "0")
	.attr("stop-color", colorArr[3])
	;
	gradient.append("stop")
	.attr("offset", "1")
	.attr("stop-color", colorArr[4])
	;
	
	barChart.selectAll(".barRect").remove();
	var barRect = barChart.selectAll(".dataBar")
	            .data(rawData)
	            .enter().append("g");
	
	barRect.append("rect")
	    .attr("class","dataBar")
		.attr("fill", "url(#bar_gradient)")
	    .attr("x", function(d, i){
//	    	return x(d.date);
//	    	return (width/n)*i + 30;
	    	return ((width-param.margin.left)/n)*i + 30;
    	})
		.attr("width", param.pdType == 1? 16 : 8)
		.attr("y", function(d){
	    	return y(minmax[0]);
	    })
//	    .attr("rx", 2).attr("ry", 2)
	    .transition().duration(500).delay(function(d, i) { return i * 10; })
	    .attr("y", function(d){ return y(d.totCnt); })
		.attr("height", function(d){
			return height - y(d.totCnt);
		});
	
	barRect.append("rect")
	.attr("class","excs_dataBar")
	.attr("fill", "url(#excsbar_gradient)")
	.attr("x", function(d, i){
//    	return x(d.date)+8;
//    	return (width/n)*i + 38;
    	return ((width-param.margin.left)/n)*i + 38;
	})
	.attr("width", 8)
	.attr("y", function(d){
		return y(minmax[0]);
	})
//	.attr("rx", 2).attr("ry", 2)
	.transition().duration(500).delay(function(d, i) { return i * 10; })
	.attr("y", function(d){ return y(d.excsCnt); })
	.attr("height", function(d){
		return height - y(d.excsCnt);
	});

	barChart.append("path")
	    .attr("class","zeroAxis_line")
	    .style("fill","none")
	    .attr("stroke", "#a5a5a5")
	    .attr("stroke-width", 1)
	    .attr("d",function(){ return lineGenerator([[isNullToString(param.yAxisDiv) != "" ? 0 : param.margin.left, y(0)], [width+10, y(0)]]); });
	
	barChart.selectAll(".group").remove();
	var group = barChart.selectAll(".group")
	            .data(dataset)
	            .enter().append("g")
	            .attr("class","group");
	

	barChart.selectAll(".userGoalLabel").remove();
	var userGoalLabel = barChart.append("g")
	.attr("class", "userGoalLabel")
	.attr("transform","translate(0,0)")
	
	var pathString = lineGenerator([[isNullToString(param.yAxisDiv) != "" ? 0 : param.margin.left, y(userGoalValue)],[width+9, y(userGoalValue)]]);
	
	if(rangeArr[rangeArr.length-1] + rangeIntrvl/2 > userGoalValue || userGoalValue - rangeIntrvl/2 > rangeArr[0]){
		userGoalLabel.append("path")
			.attr("class","userGoalLabel_line")
			.attr("fill","none")
			.attr("stroke", colorArr[5])
			.attr("stroke-width", 0.5)
			.style("stroke-dasharray",("3,3"))
			.attr("d", pathString);
		 var objGoalTxt = "(권장:"+userGoalValue+"/목표:"+userObjVal+")";
		 var xWidth = width-100 - yAxisWidth/3;
		 if(isNullToString(userObjVal) == 0){
			 if(healthYn == "Y"){
				 objGoalTxt = "(권장:"+userGoalValue+")";				 
			 }else{
				 objGoalTxt = "목표치("+userGoalValue+")";
			 }
			 xWidth = width-55 - yAxisWidth/3;
	     }
		userGoalLabel.append("text")
		    .attr("class", "userGoalLabel_text")
		    .attr("x", xWidth)
	//		    .attr("y", y(userGoalValue)+15)
		    .text(objGoalTxt)
		    .style("font-size", "11px")
//		    .style("font-weight", "bold")
		    .style("fill", colorArr[6])
			.style("fill-opacity", "0.7");
		
		if(userGoalValue > yAxisMax){
			userGoalLabel.selectAll('.userGoalLabel_text').attr("y", y(minmax[1])+10);
		}else{
			userGoalLabel.selectAll('.userGoalLabel_text').attr("y", y(userGoalValue)+15);
		}
	
//		userGoalLabel.append("svg:image")
//			.attr("x", 20-param.margin.left-15)
//			.attr("y", y(userGoalValue)+5)
//			.attr("xlink:href", "../../images/app/contents/graph_icon_goal.png")
//			.attr("width", 12)
//			.attr("height", 12);
	}

//	barChart.selectAll(".baseRect").remove();
//	var baseRect = barChart.selectAll(".baseRect")
//	.data(rawData).enter().append("rect")
//    .on("click",function(d, i){
//    	//클릭이벤트
//    })
//	.attr("class", "baseRect")
//	.attr("x", function(d, i){
//		return i * ((width-10)/n) + 20;
//	})
//	.attr("y", y(minmax[1]))
//	.attr("width", function(d, i){
//		return Math.floor(width/n);
//	})
//	.attr("height", Math.abs(y(minmax[1]) - y(minmax[0])))
////	.attr("stroke", "gray")
////	.attr("stroke-width", "1px")
//	.style("fill-opacity", "0");

} 

}//bar end