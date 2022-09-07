from bs4 import BeautifulSoup
import requests
import csv 
import pandas as pd
# parser 1 flow
# timecheck 
# multiprocessing Pool 
# Timecheck 
# export to csv 

def get_html(url):
    r = requests.get(url, verify=False) #Response
    return r.text   #returns html code of the page

def get_all_links(html):
    soup = BeautifulSoup(html, 'lxml')
    tds = soup.find('table', class_ ='table table-bordered table-hover').find_all('td')
    links  = []
    for td in tds:
        try: 

            a = td.find('a').get('href') 
            links.append(a)
        except:
            continue
    return links


def main():
    arr = list()
    url = 'https://www.goszakup.gov.kz/ru/registry/rqc'
    all_links1 = get_all_links(get_html(url))
    arr.extend(all_links1)

    for i in range(2,10):
        x = 'https://www.goszakup.gov.kz/ru/registry/rqc?count_record=50&page={i}'
        
        all_links2 = get_all_links(get_html(x))
        arr.extend(all_links2)

    dff=pd.DataFrame()
    for i in arr:
        try:
            dfi=get_info(i)
            dff= dff.append(dfi,ignore_index=True)
            # dff = pd.concat([dff, dfi])
        except:
            continue
    # print(dff)
    dff.to_excel('dff.xlsx')

def get_info(link):
    print(link)
    table_MN = pd.read_html(link)

    df = table_MN[0].transpose()
    df.columns = df.iloc[0]
    df.drop(df.index[0],inplace=True)

    df11 = table_MN[1].transpose()
    df11.columns = df11.iloc[0]
    df11.drop(df11.index[0],inplace=True)

    df22 = table_MN[2].transpose()
    df22.columns = df22.iloc[0]
    df22.drop(df22.index[0],inplace=True)

    df33 = table_MN[3]

    df.reset_index(drop=True, inplace=True)
    df11.reset_index(drop=True, inplace=True)
    df22.reset_index(drop=True, inplace=True)
    # df11

    df_all=pd.concat([df,df11, df22,df33.head(1)], axis=1)
    return df_all
main()