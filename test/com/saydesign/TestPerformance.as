import com.saydesign.Performance;
import as2unit.framework.TestCase;

class test.com.saydesign.TestPerformance extends TestCase
{
	private var i:Number;
	private var j:Number;
	private var p:Performance;
	private var startTime:Number;
	private var MAX:Number = 900;
	
	public function TestPerformance(methodName:String)
	{
		super(methodName);
	}
	
	public function setUp()
	{
		p = new Performance();
		startTime = getTimer();
	}
	
	public function tearDown()
	{
		delete p;
	}
	
	public function testIndirectArrayAccess()
	{
		for(j = 0; j < MAX; j++)
			for(i = 0; i < 10; i++)
				if(p.ItemAt() != 1)
					fail("Something's wrong");
		trace("Indirect array access: " + (getTimer() - startTime));
	}
	
	public function testDirectArrayAccess()
	{
		var a:Array = p.getArray();
		for(j = 0; j < MAX; j++)
			for(i = 0; i < 10; i++)
				if(a[i] != 1)
					fail("Something's wrong");
		trace("Direct array access: " + (getTimer() - startTime));
	}	
	
	public function test2DArrayAccess()
	{
		var k:Number;
		var da:Array = p.getDArray();
		for(k = 0; k < MAX; k++)
			for(i = 0; i < 10; i++)
				if(da[i][0] == 1)
					continue;
		trace("Double array access: " + (getTimer() - startTime));
	}
	
	public function testDirectAccessSetting()
	{
		//var da:Array = p.getDArray();
		for(j = 0; j < MAX; j++)
			for(i = 0; i < 10; i++)
				p.da[i][0] = 1;
		trace("Direct access setting: " + (getTimer() - startTime));
	}
	public function testIndirectAccessSetting()
	{
		for(j = 0; j < MAX; j++)
			for(i = 0; i < 10; i++)
				p.setItemAt(i, 0, 1);
		trace("Indirect access setting: " + (getTimer() - startTime));
	}
	
	
}