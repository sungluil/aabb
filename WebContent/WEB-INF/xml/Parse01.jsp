<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% 
//XML ����
TextAsset spriteText = Resources.Load( "XML/" + fileName ) as TextAsset;

byte[] arrByte = Encoding.ASCII.GetBytes( spriteText );
MemoryStream stream = new MemoryStream( arrByte );

XmlReader xmlReader = XmlReader.Create( stream );

_Parse( xmlReader );

xmlReader.Close();


private void _Parse( XmlReader reader )
{
      while( reader.Read() )
      {
                    switch( reader.NodeType )
                      {
                                    case XmlNodeType.Element:
                                          //     
                                    break;
                                    case XmlNodeType.Text:
                                          //
                                    break;
                                    case XmlNodeType.EndElement:
                                          //
                                    break;
                      }
            }
}

//TEXT ����
TextAsset txtAsset = Resources.Load( "txt�����̸�" ) as TextAsset;

StringReader stringReader = new Stringreader( txtAsset.text );

string line;
while( (line = stringReader.ReadLine()) != null )
{
      string fileName = line;
      FileStream fileStream = File.Open( fileName, FileMode.OpenOrCreate );
     
        // TODO something


      fileStream.Close();
 }
%>