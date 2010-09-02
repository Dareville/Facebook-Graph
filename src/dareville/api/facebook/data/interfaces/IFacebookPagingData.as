package dareville.api.facebook.data.interfaces
{
	/**
	 * The <code>IFacebookPagingData</code> interface defines value objects 
	 * representing items that support paging data on a page feed.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public interface IFacebookPagingData
		extends IFacebookBaseData
	{
		/**
		 * URL link to retrieve the previous list of items
		 * 
		 * @return String 
		 */	
		function get paging_previous():String;
		
		/**
		 * URL link to retrieve the next list of items
		 * 
		 * @return String 
		 */	
		function get paging_next():String;
	}
}