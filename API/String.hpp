#pragma once

namespace IL2CPP
{
	namespace String
	{
		Unity::System_String* New(const char* m_String)
		{
			return reinterpret_cast<Unity::System_String*(IL2CPP_CALLING_CONVENTION)(const char*)>(Functions.m_StringNew)(m_String);
		}

		Unity::System_String* New(std::string m_String) 
		{ 
			return New(&m_String[0]);
		}
	}
}