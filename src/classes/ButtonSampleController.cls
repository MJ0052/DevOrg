public class ButtonSampleController {

    public String Page {get; set;}
    public String OpenPageURL {get; set;}
    
    public void ButtonSampleController()
    {
        Page = '' ;
        OpenPageURL = '' ;
    }
    
    public PageReference redirect()
    {
        if(Page == 'google')
        {
            OpenPageURL = '' ;
        }
        if(Page == 'blog')
        {
            OpenPageURL = '';
        }
        System.debug('GOOOGLE');
        return null;
    }

}