package dareville.api.facebook.data.notes
{
	import dareville.api.facebook.data.common.FacebookPagingData;
	
	/**
	 * The <code>FacebookNoteCollectionData</code> class is a value object 
	 * representing a collection of note data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookNoteCollectionData 
		extends FacebookPagingData
	{
		private var _notes : Array;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function FacebookNoteCollectionData(data:Object=null)
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
			
			_notes = new Array();
			
			if( data.hasOwnProperty( "data" ) )
			{
				var arr_notes : Array = data.data;
				var arr_notes_len : int = arr_notes.length;
				for( var i : int = 0; i < arr_notes_len; i++ )
				{
					var note : FacebookNoteData = new FacebookNoteData( arr_notes[i] );
					_notes.push( note );
				}
			}
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Array of <code>FacebookNoteData</code>
		 * 
		 * @return Array 
		 */		
		public function get notes():Array
		{
			return _notes;
		}
	}
}