# main app
require ['jquery','use!underscore','use!jwplayer','text!/pings/pingcast.xml'],
($, _, jwplayer, pingcast)->
	$pingcast = $(pingcast)
	$items = $pingcast.find('item')
	$btn_next = $('#next')
	$btn_prev = $('#previous')
	$btn_next.click =>
		@init(1)
	$btn_prev.click =>
		@init(-1)
	
	
	
	@init = (dir)=>
		dir = dir || 0
		index = (index || parseInt(window.location.hash.replace('#', '')) || 1)+dir
		$item = $($items.get($items.length - index))
		if index >1
			$btn_prev.show()
		else
			$btn_prev.hide()
		if index <$items.length
			$btn_next.show()
		else
			$btn_next.hide()
		# build html
		$ping = $('.ping')
		$ping.find('.title').html($item.children('title').html())	
		$ping.find('.description').html($item.children('description').html())	
		
		# enclosure
		enclosuretype = $item.children('enclosure').attr('type')
		if enclosuretype == "audio/x-mp3"
			jwheight = 30
		else
			jwheight = 480
		jwplayer('player').setup(
			file: $item.children('enclosure').attr('url')
			height:jwheight
			width:640
		)

	
		
		window.location.hash = index
	@init()

	
