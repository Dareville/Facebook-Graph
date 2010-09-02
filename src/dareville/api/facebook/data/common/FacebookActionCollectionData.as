package dareville.api.facebook.data.common
{
	/**
	 * The <code>FacebookActionCollectionData</code> class is a value object 
	 * representing a collection of action data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookActionCollectionData 
		extends FacebookBaseData
	{
		private var _actions : Array;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function FacebookActionCollectionData(data:Object=null)
		{
			super(data);
		}
		
		//---------------------------------------------------------------------
		//
		//  Protected methods
		//
		//---------------------------------------------------------------------
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		/**
		 * @private 
		 */		
		override protected function init():void
		{
			super.init();
			
			_actions = new Array();
			if( data )
			{
				var arr_actions : Array = data as Array;
				var actions_len : int = arr_actions.length;
				for( var i : int = 0; i < actions_len; i++ )
				{
					var action : FacebookActionData = new FacebookActionData( arr_actions[i] );
					_actions.push( action );
				}
			}
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Array of <code>FacebookCommentData</code>
		 * 
		 * @return Array 
		 */		
		public function get actions():Array
		{
			return _actions;
		}
	}
}