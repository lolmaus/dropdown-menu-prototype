$.widget 'lolmaus.lolmenu',

  options:
    selItem: '.menu-item._withChildren'
    selItem_withChildren: '.menu-item._withChildren'
    selItemLink: '.menu-item-link'
    selItemList: '.menu-item-children'
    claExpanding: '-expanding'
    claExpanded: '-expanded'
    msAimDuration: 800 # Should not be small
    pxBreakpoint: parseInt window.breakpoint, 10


  _create: ->

    $window = $ window

    @element.on 'mouseenter', @options.selItem_withChildren, (event) =>

      # Only act if window width is sufficient
      return unless $window.width() > @options.pxBreakpoint

      # Retrieving current item
      $currentItem = $(event.target).closest @options.selItem_withChildren
        .addClass @options.claExpanding

      console.log jQuery._data( $currentItem.get(0), "events" );


      # Setting the flag that prevents the click action
      $currentItem.get(0).preventClick = true

      # Retrieving current list
      $list = $currentItem.children @options.selItemList

        # Expanding it
        .finish()
        .slideDown @options.msAimDuration, =>
          # This callback is fired when animation completes

          # Applying the state class
          $currentItem
            .removeClass @options.claExpanding
            .addClass @options.claExpanded

          # Unsetting the flag on animation completion
          $currentItem.get(0).preventClick = false

      # Lists close to right screen edge should have
      # different offset
      listRightOffset = $window.innerWidth() - $list.offset().left - $list.outerWidth()
      if listRightOffset < 200
        $list.css
          left: 'auto'
          right: window.menuChildItemOffset

      # Applying the mouseleave event to current item

      $currentItem.off 'mouseleave'
      $currentItem.mouseleave (event) =>

        # Only act if window width is sufficient
        return unless $window.width() > @options.pxBreakpoint

        # Removing  the state class
        $currentItem.removeClass @options.claExpanded

        # Collapsing current list
        $list
#          .finish()
          .slideUp @options.msAimDuration, =>
            # This callback is fired when animation completes

            # Resetting offset
            $list.css
              left: ''
              right: ''



    @element.on 'click', @options.selItem_withChildren, (event) =>

      $currentItem = $(event.target).closest @options.selItem_withChildren

      if $currentItem.get(0).preventClick
        event.preventDefault()


  _delay: (timeout, callback) ->
    setTimeout callback, timeout

$ ->
  $('.menu').lolmenu()