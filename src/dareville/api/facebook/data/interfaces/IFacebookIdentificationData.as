package dareville.api.facebook.data.interfaces
{
	/**
	 * The <code>IFacebookIdentificationData</code> interface defines value 
	 * objects representing items that support identification data on a page 
	 * feed.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public interface IFacebookIdentificationData 
		extends IFacebookBaseData
	{
		/**
		 * ID property
		 * 
		 * @return String
		 */	
		function get id():String;
		
		/**
		 * Name property
		 * 
		 * @return String 
		 */	
		function get name():String;
	}
}