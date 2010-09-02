package dareville.api.facebook.data.notes
{
	/**
	 * The <code>FacebookNoteCreateData</code> class is a value object 
	 * representing note data to be created.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookNoteCreateData
	{
		private var _subject : String;
		private var _message : String;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor  
		 * 
		 * @param subject Subject
		 * @param message Message
		 */		
		public function FacebookNoteCreateData( subject : String, message : String )
		{
			_subject = subject;
			_message = message;
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------


		public function get subject():String
		{
			return _subject;
		}

		public function get message():String
		{
			return _message;
		}

	}
}