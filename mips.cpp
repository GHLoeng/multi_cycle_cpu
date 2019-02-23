#include <iostream>
#include <fstream>
#include <cstring>
#include <map>
#include <sstream>
#include <iomanip>
#include <bitset>
using namespace std;
map<string,pair<char,string> > opcodes;
string Rtype (string a,int rs,int rt,int rd,int sa=0,int funct=0)
{
	string 	number;
	stringstream change;	
	change<<opcodes[a].second<<bitset<5>(rs)
		<<bitset<5>(rt)<<bitset<5>(rd)
		<<bitset<5>(sa)<<bitset<6>(funct);
	change>>number;
	return number;
};
string Itype (string a,int rs,int rt,int immed)
{
	string 	number;
	stringstream change;
	change<<opcodes[a].second<<bitset<5>(rs)
		<<bitset<5>(rt)<<bitset<16>(immed);
	change>>number;
	return number;
}
string Jtype (string a,int addr)
{
	string 	number;
	stringstream change;
	change<<opcodes[a].second<<bitset<26>(addr);
	change>>number;
	return number;
}
int main()
{
	ifstream in;
	ofstream out;
	in.open("mapop.txt");
	while (!in.eof())
	{
		string name,op;
		char type;
		in>>name>>type>>op;
		opcodes[name]=make_pair(type,op);
	}
	in.close();
	in.open("mips.txt");
	out.open("rom_data.txt");
	while (!in.eof())
	{
		string name;
		string change;
		in>>name;
		if (name.empty())
		break;
		if (opcodes[name].first=='j')
		{
			int addr;
			if (name=="halt")
			addr=0;
			else
			in>>hex>>addr;
			change=Jtype(name,addr);			
		}
		else if (opcodes[name].first=='r')
		{
			int rs,rt,rd,sa;
			if (name=="sll")
			{
				in>>dec>>rd>>rt>>sa;
				change=Rtype(name,0,rt,rd,sa);
			}
			else if (name=="jr")
			{
				in>>dec>>dec>>rs;
				//cout<<rs<<endl;
				change=Rtype(name,rs,0,0);
			}
			else
			{
				in>>dec>>rd>>rs>>rt;
				change=Rtype(name,rs,rt,rd);
			}
		}
		else if (opcodes[name].first=='i')
		{
			int rs,rt,immed;
			if (name=="sw" || name=="lw")
			{
				in>>dec>>rt>>immed>>rs;
			}
			else if (name=="beq" || name=="bne")
			{
				in>>dec>>rs>>rt>>immed;
			}
			else if (name=="bgtz")
			{
				in>>dec>>rs>>immed;
				rt=0;
			}
			else
			{
				in>>dec>>rt>>rs>>immed;
			}
			change=Itype(name,rs,rt,immed);
		}
		//cout<<change<<endl;
		for(int i=0;i<32;i++)
		{
			out<<change[i];
			if (i%8==7 && i!=31)
			out<<" ";
		}
		out<<endl;
	}
	out.close();
	cout<<"complie finish\n";
	return 0;
}
