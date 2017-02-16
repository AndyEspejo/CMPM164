{
	_title=[[story title]],
	_subtitle=[[story subtitle]],
	[ [[chose_cake]] ]={
		{type='write',line=[[sweet.]]},
		{type='pause'},
		{type='write',line=[[the value of x was ...]]},
		{type='pause'},
		{type='write-expr',expr=function() return x end},
		{type='pause'},
	}, -- chose_cake
	[ [[high]] ]={
		{type='write',line=[[x was high.]]},
		{type='pause'},
	}, -- high
	[ [[init]] ]={
		{type='write',line=[[a line by itself.]]},
		{type='pause'},
		{type='write',line=[[two lines]]},
		{type='write',line=[[together.]]},
		{type='pause'},
		{type='do',code=function() x = 5 end},
		{type='pause'},
		{type='ite',['if']=function() return x < 13 end,['then']=[[low]],['else']=[[high]]},
		{type='pause'},
	}, -- init
	[ [[low]] ]={
		{type='write',line=[[x was low.]]},
		{type='pause'},
		{type='goto',label=[[more]]},
		{type='pause'},
	}, -- low
	[ [[chose_death]] ]={
		{type='write',line=[[sorry.]]},
		{type='pause'},
	}, -- chose_death
	[ [[more]] ]={
		{type='write',line=[[which will you choose?]]},
		{type='choice',options={
			{text=[[cake]],label=[[chose_cake]]},
			{text=[[death]],label=[[chose_death]]},
		}}, -- options
		{type='pause'},
	}, -- chose_death
}
