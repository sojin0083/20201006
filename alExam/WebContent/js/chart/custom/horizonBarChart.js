/**
d3 라이브러리를 이용한 검사지 차트 생성 
**/

function HorizonBarChart(_param){
	var param = _param || {};
	
	var margin = {top: 30, right: 10, bottom: 50, left: 50},
    width = 500,
    height = 300;

	var data = param.data;

	// Add svg to
	var svg = d3.select(param.div)
                 .append('svg')
                 .attr('width', width + margin.left + margin.right)
                 .attr('height', height + margin.top + margin.bottom)
                 .append('g').attr('transform', 'translate(' + margin.left + ',' + margin.top + ')')
                 ;
	
	// set the ranges
	var y = d3.scaleBand()
	    .range([height, 0])
	    .padding(0.1);
	
	var x = d3.scaleLinear()
	    .range([0, width]);
	
	// Scale the range of the data in the domains
	x.domain(d3.extent(data, function (d) {
	    return d.point;
	}));
	y.domain(data.map(function (d) {
	    return d.item;
	}));
	
	// append the rectangles for the bar chart
	svg.selectAll(".bar")
	    .data(data)
	    .enter().append("rect")
	    .attr("class", function (d) {
	        return "bar bar--" + (d.point < 0 ? "negative" : "positive");
	    })
	    .attr("x", function (d) {
	        return x(Math.min(0, d.point));
	    })
	    .attr("y", function (d) {
	        return y(d.item);
	    })
	    .attr("width", function (d) {
	        return Math.abs(x(d.point) - x(0));
	    })
	    .attr("height", y.bandwidth());
	
	// add the x Axis
	svg.append("g")
	    .attr("transform", "translate(0," + height + ")")
	    .call(d3.axisBottom(x))
	    ;

	// add the y Axis
	svg.append("g")
	    .attr("class", "y axis")
	    //.attr("transform", "translate(" + x(0) + ",0)")
	    .attr("transform", "translate(0, 0)")	    
	    .call(d3.axisRight(y))
	    ;
	
}