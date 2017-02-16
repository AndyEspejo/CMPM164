{
	_title=[[realistic rice]],
	_subtitle=[[a cooking simulator]],
	[ [[bad]] ]={
		{type='write',line=[[an unslightly brown crust.]]},
		{type='pause'},
		{type='write',line=[[sad.]]},
		{type='pause'},
	}, -- bad
	[ [[good]] ]={
		{type='write',line=[[a perfect, if basic, meal.]]},
		{type='pause'},
		{type='do',code=function() delta = time() - t end},
		{type='write-expr',expr=function() return delta.." seconds" end},
		{type='pause'},
		{type='write',line=[[and not a moment more.]]},
		{type='pause'},
	}, -- good
	[ [[serve]] ]={
		{type='write',line=[[you open the cooker.]]},
		{type='write',line=[[fluffing the grains with]]},
		{type='write',line=[[a paddle, you find...]]},
		{type='pause'},
		{type='ite',['if']=function() return rnd() < 0.5 end,['then']=[[good]],['else']=[[bad]]},
		{type='pause'},
	}, -- serve
	[ [[init]] ]={
		{type='write',line=[[dinner time.]]},
		{type='pause'},
		{type='write',line=[[four servings of rice.]]},
		{type='write',line=[[that's not so bad.]]},
		{type='write',line=[[you can do this.]]},
		{type='pause'},
		{type='write',line=[[you rinse the grains.]]},
		{type='write',line=[[you measure out some water.]]},
		{type='pause'},
		{type='do',code=function() t = time() end},
		{type='write',line=[[click.]]},
		{type='write',line=[[the cooker is active.]]},
		{type='pause'},
		{type='goto',label=[[loop]]},
		{type='pause'},
	}, -- init
	[ [[loop]] ]={
		{type='write',line=[[the rice has been cooking,]]},
		{type='write',line=[[but you aren't sure how long.]]},
		{type='pause'},
		{type='write',line=[[should you serve it now?]]},
		{type='choice',options={
			{text=[[yup]],label=[[serve]]},
			{text=[[i'm still thinking...]],label=[[loop]]},
			{text=[[naw, wait a bit]],label=[[loop]]},
		}}, -- options
		{type='pause'},
	}, -- loop
}
