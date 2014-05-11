(function() {
  $.widget('lolmaus.lolmenu', {
    options: {
      selItem: '.menu-item._withChildren',
      selItem_withChildren: '.menu-item._withChildren',
      selItemLink: '.menu-item-link',
      selItemList: '.menu-item-children',
      claExpanding: '-expanding',
      claExpanded: '-expanded',
      msAimDuration: 800,
      pxBreakpoint: parseInt(window.breakpoint, 10)
    },
    _create: function() {
      var $window;
      $window = $(window);
      this.element.on('mouseenter', this.options.selItem_withChildren, (function(_this) {
        return function(event) {
          var $currentItem, $list, listRightOffset;
          if (!($window.width() > _this.options.pxBreakpoint)) {
            return;
          }
          $currentItem = $(event.target).closest(_this.options.selItem_withChildren).addClass(_this.options.claExpanding);
          console.log(jQuery._data($currentItem.get(0), "events"));
          $currentItem.get(0).preventClick = true;
          $list = $currentItem.children(_this.options.selItemList).finish().slideDown(_this.options.msAimDuration, function() {
            $currentItem.removeClass(_this.options.claExpanding).addClass(_this.options.claExpanded);
            return $currentItem.get(0).preventClick = false;
          });
          listRightOffset = $window.innerWidth() - $list.offset().left - $list.outerWidth();
          if (listRightOffset < 200) {
            $list.css({
              left: 'auto',
              right: window.menuChildItemOffset
            });
          }
          $currentItem.off('mouseleave');
          return $currentItem.mouseleave(function(event) {
            if (!($window.width() > _this.options.pxBreakpoint)) {
              return;
            }
            $currentItem.removeClass(_this.options.claExpanded);
            return $list.slideUp(_this.options.msAimDuration, function() {
              return $list.css({
                left: '',
                right: ''
              });
            });
          });
        };
      })(this));
      return this.element.on('click', this.options.selItem_withChildren, (function(_this) {
        return function(event) {
          var $currentItem;
          $currentItem = $(event.target).closest(_this.options.selItem_withChildren);
          if ($currentItem.get(0).preventClick) {
            return event.preventDefault();
          }
        };
      })(this));
    },
    _delay: function(timeout, callback) {
      return setTimeout(callback, timeout);
    }
  });

  $(function() {
    return $('.menu').lolmenu();
  });

}).call(this);
